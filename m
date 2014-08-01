From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 1 Aug 2014 19:02:27 +0800
Subject: [Query] How to pass reboot arguments to secure firmware with
 PSCI spec
In-Reply-To: <53DB6A18.5050904@arm.com>
References: <20140801180652.72e722be@xhacker>
	<53DB6A18.5050904@arm.com>
Message-ID: <20140801190227.116f4c39@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Fri, 1 Aug 2014 03:21:12 -0700
Sudeep Holla <sudeep.holla@arm.com> wrote:

> 
> 
> On 01/08/14 11:06, Jisheng Zhang wrote:
> > Hi Catalin and Will,
> >
> > I noticed that the following commit implement reboot via. PSCI
> > SYSTEM_RESET function. So my question is how to handle the reboot
> > arguments?
> >
> 
> What reboot arguments do you want to handle ?

man 2 reboot

...

int reboot(int magic, int magic2, int cmd, void *arg);

...

I want to pass "void *arg" to secure firmware.


> 
> >
> >> static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> >> {
> >>        invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> >
> > How to pass cmd to secure firmware?
> >
> 
> What cmd do you want to pass ? The function id is already handled. What
> else do you want to pass ?

the "const char *cmd", usually this is the "abc" if user type "reboot abc"
under shell.

For example, android usually type "reboot recovery", the "recovery" will be
passed to next boot kernel boot args.

> 
> If you see PSCI v0.2 spec, the SYSTEM_RESET and SYSTEM_SHUTDOWN takes no
> parameters.

Yes. I know it. That's why I need your help/suggestions about how to handle
the situation above.

Thanks for your input,
Jisheng

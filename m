From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Apr 2013 11:45:28 +0100
Subject: Kexec couldn't reboot capture kernel on pandaboard ES with
 OMAP4460
In-Reply-To: <5166E289.8070104@wwwdotorg.org>
References: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
 <51658B1A.6090706@wwwdotorg.org>
 <CAFNq8R6mRJRygfnYvZgwVWOqsrhrjNUYzyZGU0cVsnE30W_xGg@mail.gmail.com>
 <5166E289.8070104@wwwdotorg.org>
Message-ID: <20130412104528.GE12363@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 05:19:21PM +0100, Stephen Warren wrote:
> On 04/10/2013 10:46 PM, Li Haifeng wrote:
> > 2013/4/10 Stephen Warren <swarren@wwwdotorg.org>:
> >> On 04/10/2013 03:35 AM, Li Haifeng wrote:
> >>> Hi, everyone.
> >>>
> >>> Recently, I try to run kdump on pandaboard ES with omap4460. After
> >>> load capture kernel by "kexec -l" and execute "kexec -e", the serial
> >>> port output "Starting new kernel" and "Bye", then the system hangs up.
> >>>
> >>> I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.
> >>
> >> This is a shot in the dark. I assume you have SMP enabled. Can you use
> >> hotplug to remove all CPUs other than CPU0, so that the kexec happens on
> >> the boot CPU? That is certainly necessary for kexec to work correctly on
> >> Tegra.
> > 
> > Thanks for your attention.
> > 
> > I do disable SMP feature. And the .config file for v3.8 could be found here:
> > http://pastehtml.com/view/cylyrfejt.txt
> ...
> > The output:
> > [   57.373687] Starting new kernel
> > [   57.377044] Bye!
> > 
> > Then system hangs.
> 
> Oh well, you've exhausted my knowledge I'm afraid! I can only suggesting
> trying to enable earlyprintk and/or uncompressor debug in the kernel
> you're kexec'ing and see if that yields any clue. Either that, or JTAG!

Also worth using the bleeding edge kexec-tools (i.e. build from source),
especially if you want to anything device-tree related.

Back to the SMP point: Stephen, did you ever get anywhere with that
disable_nonboot_cpus thread from a few months back? I'm still keen to get
that working, and I *thought* we had a potential solution...

Will

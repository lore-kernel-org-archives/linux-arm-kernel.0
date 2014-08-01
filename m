From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 01 Aug 2014 11:21:12 +0100
Subject: [Query] How to pass reboot arguments to secure firmware with
 PSCI spec
In-Reply-To: <20140801180652.72e722be@xhacker>
References: <20140801180652.72e722be@xhacker>
Message-ID: <53DB6A18.5050904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/08/14 11:06, Jisheng Zhang wrote:
> Hi Catalin and Will,
>
> I noticed that the following commit implement reboot via. PSCI SYSTEM_RESET
> function. So my question is how to handle the reboot arguments?
>

What reboot arguments do you want to handle ?

>
>> static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>> {
>>        invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>
> How to pass cmd to secure firmware?
>

What cmd do you want to pass ? The function id is already handled. What
else do you want to pass ?

If you see PSCI v0.2 spec, the SYSTEM_RESET and SYSTEM_SHUTDOWN takes no
parameters.

Regards,
Sudeep

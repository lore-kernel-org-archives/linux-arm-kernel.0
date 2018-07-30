From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 30 Jul 2018 10:59:21 +0200
Subject: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
In-Reply-To: <74f80458-2d04-c161-c82d-55739e46e661@arm.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
 <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
 <0fce3ee6-873e-154f-b61e-546d9da338df@xilinx.com>
 <8b08583c-121f-347a-700a-17b5d7784309@arm.com>
 <d2eaaf6d-01f9-2daa-ea1f-3396e3b93104@xilinx.com>
 <74f80458-2d04-c161-c82d-55739e46e661@arm.com>
Message-ID: <d73d3580-4ec1-a281-4585-5c776fc08c79@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 26.7.2018 15:29, Sudeep Holla wrote:
> Hi Michal,
> 
> Sorry somehow missed this email.
> 
> On 19/07/18 11:47, Michal Simek wrote:
>> On 9.7.2018 15:21, Sudeep Holla wrote:
> 
> [...]
> 
>>>
>>> I think with efi_reboot, if user execute the command "reboot warm", it
>>> will set REBOOT_WARM. I was thinking something similar for psci too. I
>>> can drop REBOOT_SOFT if that's not correct.
>>
>> Have you found more details about efi_reboot and passing information in
>> case of reboot warm?
>>
> 
> I was just referring to drivers/firmware/efi/reboot.c- function efi_reboot.
> 
> Anyways the function reboot_setup in kernel/reboot.c sets the reboot
> mode parsing the string passed by the user(e.g.: warm, cold, hard, gpio,
> soft,..etc it just scans the first character TBH)

ok. I see. It is just reusing that reboot=X passed via kernel command line.

Thanks,
Michal

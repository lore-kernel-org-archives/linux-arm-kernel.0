From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 2 Nov 2015 09:48:06 -0600
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <55F059F9.3080200@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <55F059F9.3080200@arm.com>
Message-ID: <563785B6.50800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2015 11:10 AM, Marc Zyngier wrote:
> Jeremy,
>
> I can see two issues here: we have a screaming interrupt, and
> we seem to corrupt some workqueue.
>
> How did you get this to work? Firmware release?

Marc,

I'm responding because its been a month or so since my last response, 
and I haven't forgotten about this issue.

First, any custom tianocore build (*) should work. The required changes 
have been in the last few linaro snapshots as well 
(http://snapshots.linaro.org/components/kernel/linaro-edk2/, currently 
at 40) but I personally haven't had a lot of luck with the prebuilt 
images due to problems unrelated to this change. Others may have more luck.

* For those that don't know, tianno core is at:

https://github.com/tianocore/edk2.git
Use the master branch

After setting the environment variables/dependencies appropriately:

make -f ArmPlatformPkg/ArmJunoPkg/Makefile all

Will create a functional ACPI firmware image for all recent kernels, 
including ACPI/PCIe ones.

Thanks for everyone's patience on this,

	

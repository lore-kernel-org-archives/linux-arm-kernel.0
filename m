From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 10:41:25 +0530
Subject: [PATCH 04/11] arm64: dts: Initial DTS files for Broadcom Stingray
 SOC
In-Reply-To: <64f4e7c4-d619-2ac2-438b-91d48ea4260b@broadcom.com>
References: <1494071686-19098-1-git-send-email-anup.patel@broadcom.com>
 <1494071686-19098-5-git-send-email-anup.patel@broadcom.com>
 <64f4e7c4-d619-2ac2-438b-91d48ea4260b@broadcom.com>
Message-ID: <CAALAos_R=zRKSPd8TYyG8NC4s3D6U-vbk83gJBFP__+Wr4G9Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 2:02 AM, Scott Branden
<scott.branden@broadcom.com> wrote:
> One update below needed dealing with memreserve
>
>
> On 17-05-06 04:54 AM, Anup Patel wrote:
>>
>> The Broadcom Stingray SoC is a new member in Broadcom iProc
>> SoC family.
>>
>> This patch adds initial DTS files for Broadcom Stingray SoC
>> and two of its reference boards (bcm958742k and bcm958742t).
>>
>> We have lot of reference boards and large number of devices
>> in Broadcom Stingray SoC so eventually we will have quite
>> a few DTS files for Stingray. To tackle, we have added a
>> separate directory for Stingray DTS files.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> ---
>>  arch/arm64/boot/dts/broadcom/Makefile              |   1 +
>>  arch/arm64/boot/dts/broadcom/stingray/Makefile     |   6 +
>>  .../boot/dts/broadcom/stingray/bcm958742-base.dtsi |  64 +++++
>>  .../boot/dts/broadcom/stingray/bcm958742k.dts      |  48 ++++
>>  .../boot/dts/broadcom/stingray/bcm958742t.dts      |  40 +++
>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 307
>> +++++++++++++++++++++
>>  6 files changed, 466 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
>>  create mode 100644
>> arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile
>> b/arch/arm64/boot/dts/broadcom/Makefile
>> index f1caece..a7c3208 100644
>> --- a/arch/arm64/boot/dts/broadcom/Makefile
>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
>> @@ -2,6 +2,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
>>  dtb-$(CONFIG_ARCH_BCM_IPROC) += ns2-svk.dtb ns2-xmc.dtb
>>  dtb-$(CONFIG_ARCH_VULCAN) += vulcan-eval.dtb
>>
>> +dts-dirs       := stingray
>>  always         := $(dtb-y)
>>  subdir-y       := $(dts-dirs)
>>  clean-files    := *.dtb
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile
>> b/arch/arm64/boot/dts/broadcom/stingray/Makefile
>> new file mode 100644
>> index 0000000..f70028e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
>> @@ -0,0 +1,6 @@
>> +dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742k.dtb
>> +dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
>> +
>> +always         := $(dtb-y)
>> +subdir-y       := $(dts-dirs)
>> +clean-files    := *.dtb
>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> new file mode 100644
>> index 0000000..e3a2a36
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>> @@ -0,0 +1,64 @@
>> +/*
>> + *  BSD LICENSE
>> + *
>> + *  Copyright(c) 2016-2017 Broadcom.  All rights reserved.
>> + *
>> + *  Redistribution and use in source and binary forms, with or without
>> + *  modification, are permitted provided that the following conditions
>> + *  are met:
>> + *
>> + *    * Redistributions of source code must retain the above copyright
>> + *      notice, this list of conditions and the following disclaimer.
>> + *    * Redistributions in binary form must reproduce the above copyright
>> + *      notice, this list of conditions and the following disclaimer in
>> + *      the documentation and/or other materials provided with the
>> + *      distribution.
>> + *    * Neither the name of Broadcom nor the names of its
>> + *      contributors may be used to endorse or promote products derived
>> + *      from this software without specific prior written permission.
>> + *
>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>> +
>> +/*
>> + * Reserve portion of RAM used by secured firmware
>> + * running in background.
>> + */
>
> This memreserve comment was changed from the internal version of the dtsi
> file.  Comment is now misleading as I don't think this memreserve is used at
> all.  EFI Loader passes in the memory configuration.  Comment needs to be
> updated to indicate this is not used by standard bootloader.  Or, simply
> remove the memreserve here.

Actually its always better to have memreserve added by bootloader.

I will try with latest bootloader and if possible I will remove the memreserve
itself.

Regards,
Anup

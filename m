From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 15 Oct 2015 23:32:27 +0200
Subject: [PATCH v2 2/2] ARM: dts: bcm5301x: Add BCM SVK DT files
In-Reply-To: <20151015212540.GR32089@broadcom.com>
References: <1444860890-28649-1-git-send-email-jonmason@broadcom.com>
 <1444860890-28649-3-git-send-email-jonmason@broadcom.com>
 <56200F4F.5060501@hauke-m.de> <562012B4.1000800@hauke-m.de>
 <20151015212540.GR32089@broadcom.com>
Message-ID: <56201B6B.3080904@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 11:25 PM, Jon Mason wrote:
> On Thu, Oct 15, 2015 at 10:55:16PM +0200, Hauke Mehrtens wrote:
>> On 10/15/2015 10:40 PM, Hauke Mehrtens wrote:
>>> On 10/15/2015 12:14 AM, Jon Mason wrote:
>>>> Add device tree files for Broadcom Northstar based SVKs.  Since the
>>>> bcm5301x.dtsi already exists, all that is necessary is the dts files to
>>>> enable the UARTs (and specify the RAM size for the 4708/9).  With these
>>>> files, the SVKs are able to boot to shell.
>>
>> One additional question. What flash are you using on these boards? For
>> some common NAND flash properties you only have to include
>> bcm5301x-nand-cs0-bch8.dtsi or do these boards use serial or parallel flash?
> 
> To be honest, I haven't gotten far enough to investigate that.  I am
> assuming that it is "brcm,nand-iproc" like NSP (which is different
> than the file you reference).  

It uses brcm,nand-iproc, but this driver also needs some information
about the nand chip connected to that controller, most board vendors are
using NAND chips with the same settings and we put these settings to
bcm5301x-nand-cs0-bch8.dtsi.

Hauke

> 
> Thanks,
> Jon
> 
>>
>> Hauke
>>
>>>>
>>>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>>>> ---
>>>>  arch/arm/boot/dts/Makefile       |  5 +++-
>>>>  arch/arm/boot/dts/bcm94708.dts   | 56 +++++++++++++++++++++++++++++++++++
>>>>  arch/arm/boot/dts/bcm94709.dts   | 56 +++++++++++++++++++++++++++++++++++
>>>>  arch/arm/boot/dts/bcm953012k.dts | 63 ++++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 179 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/arm/boot/dts/bcm94708.dts
>>>>  create mode 100644 arch/arm/boot/dts/bcm94709.dts
>>>>  create mode 100644 arch/arm/boot/dts/bcm953012k.dts
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 233159d..96a1b58 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -72,7 +72,10 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>>>  	bcm47081-buffalo-wzr-900dhp.dtb \
>>>>  	bcm4709-asus-rt-ac87u.dtb \
>>>>  	bcm4709-buffalo-wxr-1900dhp.dtb \
>>>> -	bcm4709-netgear-r8000.dtb
>>>> +	bcm4709-netgear-r8000.dtb \
>>>> +	bcm94708.dtb \
>>>> +	bcm94709.dtb \
>>>> +	bcm953012k.dtb
>>>>  dtb-$(CONFIG_ARCH_BCM_63XX) += \
>>>>  	bcm963138dvt.dtb
>>>>  dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
>>>> diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
>>>> new file mode 100644
>>>> index 0000000..f60bb1d
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/bcm94708.dts
>>>> @@ -0,0 +1,56 @@
>>>> +/*
>>>> + *  BSD LICENSE
>>>> + *
>>>> + *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
>>>> + *
>>>> + *  Redistribution and use in source and binary forms, with or without
>>>> + *  modification, are permitted provided that the following conditions
>>>> + *  are met:
>>>> + *
>>>> + *    * Redistributions of source code must retain the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer.
>>>> + *    * Redistributions in binary form must reproduce the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer in
>>>> + *      the documentation and/or other materials provided with the
>>>> + *      distribution.
>>>> + *    * Neither the name of Broadcom Corporation nor the names of its
>>>> + *      contributors may be used to endorse or promote products derived
>>>> + *      from this software without specific prior written permission.
>>>> + *
>>>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>>>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>>>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>>>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>>>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>>>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>>>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>>>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>>>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>>>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "bcm5301x.dtsi"
>>>
>>> Please include bcm4708.dtsi instead here.
>>>
>>>> +
>>>> +/ {
>>>> +	model = "NorthStar SVK (BCM94708)";
>>>> +	compatible = "brcm,bcm94708", "brcm,bcm4708";
>>>> +
>>>> +	aliases {
>>>> +		serial0 = &uart0;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		bootargs = "console=ttyS0,115200";
>>>> +	};
>>>> +
>>>> +	memory {
>>>> +		reg = <0x00000000 0x08000000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	status = "okay";
>>>> +};
>>>> diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/bcm94709.dts
>>>> new file mode 100644
>>>> index 0000000..88de313
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/bcm94709.dts
>>>> @@ -0,0 +1,56 @@
>>>> +/*
>>>> + *  BSD LICENSE
>>>> + *
>>>> + *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
>>>> + *
>>>> + *  Redistribution and use in source and binary forms, with or without
>>>> + *  modification, are permitted provided that the following conditions
>>>> + *  are met:
>>>> + *
>>>> + *    * Redistributions of source code must retain the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer.
>>>> + *    * Redistributions in binary form must reproduce the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer in
>>>> + *      the documentation and/or other materials provided with the
>>>> + *      distribution.
>>>> + *    * Neither the name of Broadcom Corporation nor the names of its
>>>> + *      contributors may be used to endorse or promote products derived
>>>> + *      from this software without specific prior written permission.
>>>> + *
>>>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>>>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>>>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>>>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>>>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>>>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>>>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>>>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>>>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>>>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "bcm5301x.dtsi"
>>>
>>> Please include bcm4708.dtsi instead here.
>>>
>>>> +
>>>> +/ {
>>>> +	model = "NorthStar SVK (BCM94709)";
>>>> +	compatible = "brcm,bcm94709", "brcm,bcm4708";
>>>
>>> I assume this is a bcm4709 SoC, then you should used this line:
>>> compatible = "brcm,bcm94709", "brcm,bcm4709", "brcm,bcm4708";
>>>
>>> If you would put these device tree files into the bootloader and we
>>> would have to do an workaround for all bcm4709 SoC, but nor for the
>>> bcm4708 Soc Linux would be able to detect this.
>>>
>>>> +
>>>> +	aliases {
>>>> +		serial0 = &uart0;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		bootargs = "console=ttyS0,115200";
>>>> +	};
>>>> +
>>>> +	memory {
>>>> +		reg = <0x00000000 0x08000000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	status = "okay";
>>>> +};
>>>> diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
>>>> new file mode 100644
>>>> index 0000000..8e99521
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/bcm953012k.dts
>>>> @@ -0,0 +1,63 @@
>>>> +/*
>>>> + *  BSD LICENSE
>>>> + *
>>>> + *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
>>>> + *
>>>> + *  Redistribution and use in source and binary forms, with or without
>>>> + *  modification, are permitted provided that the following conditions
>>>> + *  are met:
>>>> + *
>>>> + *    * Redistributions of source code must retain the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer.
>>>> + *    * Redistributions in binary form must reproduce the above copyright
>>>> + *      notice, this list of conditions and the following disclaimer in
>>>> + *      the documentation and/or other materials provided with the
>>>> + *      distribution.
>>>> + *    * Neither the name of Broadcom Corporation nor the names of its
>>>> + *      contributors may be used to endorse or promote products derived
>>>> + *      from this software without specific prior written permission.
>>>> + *
>>>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>>>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>>>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>>>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>>>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>>>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>>>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>>>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>>>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>>>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>>>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "bcm5301x.dtsi"
>>>
>>> What is the difference between bcm53012 and bcm4708?
>>>
>>> Currently we have the bcm4708.dtsi and the bcm47081.dtsi file one is for
>>> dual core SoCs and the other for the single core versions, does one of
>>> them fit BCM953012K, then you should include it?
>>>
>>>> +
>>>> +/ {
>>>> +	model = "NorthStar SVK (BCM953012K)";
>>>> +	compatible = "brcm,bcm53012", "brcm,bcm4708";
>>>
>>> I assume this is a bcm53012 SoC and a BCM953012K board, then you should
>>> used this line:
>>> compatible = "brcm,bcm953012k", "brcm,brcm53012", "brcm,bcm4708";
>>>
>>>> +
>>>> +	aliases {
>>>> +		serial0 = &uart0;
>>>> +		serial1 = &uart1;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		bootargs = "console=ttyS0,115200";
>>>> +	};
>>>> +
>>>> +	memory {
>>>> +		reg = <0x00000000 0x10000000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	clock-frequency = <62499840>;
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&uart1 {
>>>> +	clock-frequency = <62499840>;
>>>> +	status = "okay";
>>>> +};
>>>>
>>>
>>

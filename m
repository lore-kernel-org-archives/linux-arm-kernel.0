From: alexg@meprolight.com (Alex Gershgorin)
Date: Wed, 7 Mar 2012 16:05:29 +0200
Subject: I.MX35 PDK
In-Reply-To: <CAOMZO5CyGazr1=kLF51W7S7ZpEy2Mg4k2n_ZHnGimSyu2oVcrA@mail.gmail.com>
References: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A26@MEP-EXCH.meprolight.com>
 <4F562C90.6090103@freescale.com>,
 <CAOMZO5CyGazr1=kLF51W7S7ZpEy2Mg4k2n_ZHnGimSyu2oVcrA@mail.gmail.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D890F@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio,

 
________________________________________
From: Fabio Estevam [festevam at gmail.com]
Sent: Wednesday, March 07, 2012 2:18 PM
To: Fabio Estevam
Cc: Alex Gershgorin; linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de
Subject: Re: I.MX35 PDK

On 3/6/12, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Alex Gershgorin wrote:
>> Hi Fabio,
>>
>>
>>
>> How I can get information about accesses to CMOS_RST_B and CSI_PWDN bits
>> of MC9S08DZ60 processor.
>>
>> I need address of this register and bits mapping in this register.

CMOS_RESET: Bit 6 of register 0x1a
CMOS_ENABLE: Bit 1 of register 0x20

>>>After the mx35pdk lcd support patch gets applied I will submit a patch
>>>to adding support to all of the registers/bits definitions for
>>>>mc9s08dz60 chip.

I use a barebox boot loader which supported mc9s08dz60 driver :-)
Currently this is working, without  driver in the Linux kernel, but I have other problem:
In my I.MX35 pdk personality board on connector CN14 I measure signals CMOS_RST = 1, CSI_PWDN = 0 and all of the correct voltages,
in spite of this I get from ov2640 driver error 
Here Linux Kernel boot message:  

"Linux video capture interface: v2.00
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
ov2640 0-0030: Product ID error fb:fb" 

I cannot understand what the problem is, if someone tested this?

Regards,
Alex Gershgorin





 

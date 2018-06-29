From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 29 Jun 2018 16:39:39 +0200
Subject: [PATCH v2] arm64: dts: marvell: armada-37xx: reserve memory for
 ATF
In-Reply-To: <20180629134407.112819d2@windsurf> (Thomas Petazzoni's message of
 "Fri, 29 Jun 2018 13:44:07 +0200")
References: <20180626081701.27176-1-miquel.raynal@bootlin.com>
 <20180629134407.112819d2@windsurf>
Message-ID: <87y3ex4pxw.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel, Thomas,
 
 On ven., juin 29 2018, Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> Hello,
>
> On Tue, 26 Jun 2018 10:17:01 +0200, Miquel Raynal wrote:
>> From: Victor Gu <xigu@marvell.com>
>> 
>> The PSCI area should be reserved in Linux for PSCI operations such as
>> suspend/resume.
>> 
>> Reserve 2MiB of memory which matches the area used by ATF (BL1, BL2,
>> BL3x, see [1] in ATF source code). This covers all PSCI code and data
>> area and is 2MiB aligned, which is required by Linux for huge pages
>> handling.
>> 
>> Please note that this is a default setup allowing to perform PSCI
>> operations with legacy bootloaders. Recent bootloaders should update the
>> region size/position accordingly.
>> 
>> [1] plat/marvell/a3700/common/include/platform_def.h
>> 
>> Signed-off-by: Victor Gu <xigu@marvell.com>
>> [miquel.raynal at bootlin.com: reword of commit message, comment in the DTSI]
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 2 Apr 2014 02:26:38 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140401172933.GB7528@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
 <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <533AC67D.2060906@boundarydevices.com>
 <20140401172933.GB7528@n2100.arm.linux.org.uk>
Message-ID: <12527025bd7f486792527897e5aeaafb@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2014 1:30 AM, Russell King - ARM Linux wrote:
>On Tue, Apr 01, 2014 at 07:00:29AM -0700, Eric Nelson wrote:
>> Hi Russell,
>>
>> What value do you have for pad control register
>> IOMUXC_SW_PAD_CTL_PAD_RGMII_TX_CTL (0x020E0388)?
>
>You're referring to the iMX6Q, the Hummingboard is iMX6S, so that's 0x20e06bc.
>I have value 0x1b030.
>
>> I notice in some of the DTS files that this has a value of 0x100b0,
>> which seems wrong. Bit 16 seems to be a HYSteresis bit, and enabling
>> that seems wrong (also bit 7 seems wrong, as it's undefined in the RM).
>
>Yes, bit 7 should not be set as it's reserved, but this is ignored.
>Setting the hysteresis bit affects the input thresholds, and this signal is
>only ever used as an output.  While selecting HYS mode for an output may seem
>odd, that should not have any effect here.
>
>In any case, TX_CTL doesn't have much to do with it.  I've fully proved that
>the interface works fine under full duplex conditions, achieving 500Mbps
>transmit and 570-600Mbps receive with TCP connections (which is nicely beyond
>what freescale claim the hardware is capable of.)
>
Hi, Russell,

Since imx6q/dl/s sillicon enet have bandwidth issue, the bandwidth is 400 ~ 700 Mbps which is supplied by soc arichitecturer.
So we claim our enet performance is 460Mbps.
In fact, for our kernel 3.0.35 serial release,  kernel 3.10.17 release:
TCP tx: 470Mbps (stable)
TCP rx: 600Mbps (stable)
 
[...]

Thanks,
Andy

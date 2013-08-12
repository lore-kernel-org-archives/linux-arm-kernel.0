From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 12 Aug 2013 09:17:05 -0500
Subject: [PATCH 1/3] ARM: dts: mxs: set dcp to "disabled" by default
In-Reply-To: <21000.53151.841177.378797@ipc1.ka-ro>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
 <1375968629-10091-2-git-send-email-LW@KARO-electronics.de>
 <20130812110523.GD25292@S2101-09.ap.freescale.net>
 <21000.53151.841177.378797@ipc1.ka-ro>
Message-ID: <73E20626-6771-4F37-BE65-8AA0D49FA94D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 12, 2013, at 7:05 AM, Lothar Wa?mann wrote:

> Hi,
> 
> Shawn Guo writes:
>> On Thu, Aug 08, 2013 at 03:30:27PM +0200, Lothar Wa?mann wrote:
>>> Reintroduce 'status = "disabled"' for the dcp node that was dropped by
>>> commit 519d8b1a "Added support for Freescale's DCP co-processor".
>> 
>> For IP blocks that do not have pins to be routed on boards, it should be
>> fine to have it enabled in <soc>.dtsi.
>> 
> That means that when a new driver is added, it will start wasting
> resources on all board using that SoC unless the board maintainers
> explicitly disable that driver in DTB.
> 
> I would prefer things to be the other way:
> New drivers (no matter whether for chip-internal or external hardware)
> should require to be explicitly enabled for those platforms on which
> they are being used.

But that enablement should be in the kernel and not the device tree.  The device tree is describing the HW, if the DCP exists and is usable w/o an external IO than by default it should be enabled in the SoC .dts

- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

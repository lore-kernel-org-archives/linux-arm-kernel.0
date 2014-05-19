From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 May 2014 22:05:15 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140519160447.GB4849@atomide.com>
References: <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com> <5379CD24.6040508@ti.com>
 <20140519160447.GB4849@atomide.com>
Message-ID: <537A55EB.1080507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/14 19:04, Tony Lindgren wrote:

> In many cases however we do have multiple compatible strings that
> describe how the device is wired. See drivers/tty/serial/of_serial.c
> for example. It has "ns16550" but then it also has additional
> "nvidia,tegra20-uart", "nxp,lpc3220-uart" and "ibm,qpace-nwp-serial".

All those sound like SoC components. In that case it sounds fine to have
the device compatible contain the SoC name. We're talking here about
external, detachable devices.

>>> Not use what you're after with the SPI example though, but sounds
>>> like that's something different.
>>
>> I think Sebastien's example is just like the issue here.
> 
> Hmm is there some existing example in the kernel like that?

No, Sebastien's example was just a hypothetical case. Here, using your
way of having SoC specific data in the .dts, we would have
"sharp,ls037v7dw01-omap-dss", and in Sebastien's example with a touch
sensor we'd have, say, "synaptics,xyz123-omap-spi".

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/4b36944d/attachment.sig>

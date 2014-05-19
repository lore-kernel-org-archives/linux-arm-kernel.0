From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 May 2014 12:21:40 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140516180154.GG22031@atomide.com>
References: <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
Message-ID: <5379CD24.6040508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/14 21:01, Tony Lindgren wrote:

>> IMHO appending -omap-dss to a random device is an even bigger hack,
>> since its adding lots of bloat to the API. Let's assume there is
>> another OS using DT for ARM, but has no proper API for SPI
>> controllers and it introduces your hack to SPI devices. That would
>> mean each SPI device has -omap-spi appended (or -exynos-spi,
>> -foo-spi, ...). At least I would blame them for creating a huge
>> unmaintainable mess.
> 
> I think you're misunderstanding. I do not want the naming to
> be Linux specific. The naming should naturally be as hardware
> specific as possible. In this case something like:
> 
> compatible = "sharp,ls037v7dw01-dss", "sharp,ls037v7dw01";
> 
> Or we should probably use:
> 
> compatible = "sharp,ls037v7dw01-dpi", "sharp,ls037v7dw01";
> 
> As dpi here reflects the hardware it's connected to. The dss
> is probably a Linux name.

Well, "dss" or "omapdss" is as much a hardware term as "dpi". And "dpi"
wouldn't really be a good extension, as what we want is an omapdss
driver specific compatible string. So I think "-omapdss" is the best
extension if that method is used.

But I don't think that's really the point. The point is that the panel's
compatible string should be "sharp,ls037v7dw01", nothing else.

All the variations of "sharp,ls037v7dw01-dss" are not correct, and are
only made for Linux SW reasons. So I would say they are Linux specific
SW names, even if the words themselves are also HW terms.

> Not use what you're after with the SPI example though, but sounds
> like that's something different.

I think Sebastien's example is just like the issue here.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/86a3571b/attachment.sig>

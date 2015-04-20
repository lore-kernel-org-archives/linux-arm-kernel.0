From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Apr 2015 21:55:11 +0100
Subject: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <1429510944.30743.36.camel@mtksdaap41>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
 <1429510944.30743.36.camel@mtksdaap41>
Message-ID: <20150420205511.GL14892@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 02:22:24PM +0800, Koro Chen wrote:
> On Sat, 2015-04-18 at 18:51 +0100, Mark Brown wrote:
> > On Fri, Apr 10, 2015 at 04:14:09PM +0800, Koro Chen wrote:

> > Ah, so the SRAM is directly memory mappable.  Nice.  But we have a
> > limited amount of it so need to allocate it to a device somehow based on
> > some factor I guess?

> Yes, actually SRAM is only used for the main playback path (which is
> memif "DL1") to achieve low power in real use case. Maybe you think it's
> better to not describe this in the device tree, but to choose SRAM
> automatically if memif "DL1" is chosen?

Since it's directly memory mappable is there actually any cost in
latency terms from using the SRAM in low latency cases (or did I misread
what the code was doing there)?  If it can only be used with one
interface and there's no downside from using it...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150420/071b0bdc/attachment-0001.sig>

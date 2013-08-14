From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 22:29:40 -0700
Subject: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
In-Reply-To: <52096C75.1030305@wwwdotorg.org>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
 <52096C75.1030305@wwwdotorg.org>
Message-ID: <20130814052940.GC16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 05:15:01PM -0600, Stephen Warren wrote:
> On 08/08/2013 04:55 PM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> > and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> > just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
> 
> But the properties aren't globally standard; they apply specifically
> anywhere that this particular Synopsis IP is present. As such, I think
> at least a "synopsis," prefix is warranted.

A prefix is only really needed when a vendor is making a vendor-specific
extension on a shared binding. Since the whole binding is
synopsis-specific, I don't think there's need for a prefix here.

> And the driver should probably support both the old and new property
> names for backwards-compatibility?

Yes, that sounds appropriate if the binding is considered stable and
otherwise good.

The alternative is to have everybody just use the samsung,*
properties. There's nothing wrong with that per se, besides the fact
that if it had been caught when creating the binding, there should have
been no prefix and the properties should have been common.


-Olof

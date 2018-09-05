From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 16:48:52 +0200
Subject: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
In-Reply-To: <CAMty3ZBYjq8VBnwSqKhJgag1ARRvnPTVSpYT7SWu=A6pMwKEiA@mail.gmail.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-3-jagan@amarulasolutions.com>
 <20180905070748.g43lfdqdhmoci6pk@flea>
 <CAMty3ZBYjq8VBnwSqKhJgag1ARRvnPTVSpYT7SWu=A6pMwKEiA@mail.gmail.com>
Message-ID: <20180905144852.db2galdquxx22kjh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 01:51:25PM +0530, Jagan Teki wrote:
> On Wed, Sep 5, 2018 at 12:37 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Sep 04, 2018 at 10:06:08PM +0530, Jagan Teki wrote:
> >> Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
> >> so enable them as default.
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >> Changes for v4, v3:
> >> - none
> >> Changes for v2:
> >> - Enable for SUN8I
> >>
> >>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> >> index c2c042287c19..cfa8b96273fb 100644
> >> --- a/drivers/gpu/drm/sun4i/Kconfig
> >> +++ b/drivers/gpu/drm/sun4i/Kconfig
> >> @@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
> >>
> >>  config DRM_SUN8I_MIXER
> >>       tristate "Support for Allwinner Display Engine 2.0 Mixer"
> >> -     default MACH_SUN8I
> >> +     default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> >
> > I'm not really sure we should put it as a default. We should just
> > enable it in the defconfig.
> 
> What would be the difference in both cases it would be build as module
> since DRM_SUN4I=m for ARM64

We wouldn't force it down the throat to every user by default, even
though they have no interest in that driver being compiled into their
kernel.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/43f35ef2/attachment.sig>

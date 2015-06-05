From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 06 Jun 2015 01:03:25 +0200
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <20150605122311.GA759@ulmo.nvidia.com>
References: <4184159.j0iXe39dFB@phil> <23123577.mOoqGCAPdL@diego>
 <20150605122311.GA759@ulmo.nvidia.com>
Message-ID: <1590039.lzO65vr8K7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry

Am Freitag, 5. Juni 2015, 14:23:14 schrieb Thierry Reding:
> On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> > > If this is specific to the Rockchip implementation, shouldn't this go
> > > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > > could then simply go into the Rockchip DRM tree.
> > 
> > actually, we determined that the supply names are universal to the IP
> > (both in imx and rockchip and probably more if there are more users out
> > there). Just Russell requested that we don't pollute the generic code
> > until necessary, as it looks like the supply of those is somehow handled
> > internally on the imx.
> If it's universal then there should be no need to mention the Rockchip
> compatible specifically. Also, it might be better to submit this as two
> separate patches, one for the binding and another for the driver.
> 
> I could extract the DT binding piece myself and apply only that, then
> somebody else can apply the Rockchip change to that driver separately.

so I've sent a v4 where the dt-binding is split off (and without the Rockchip 
specific text), so if you want to take patch1, Mark could take patch2 and I 
would take the dts changes in patch3.


Heiko

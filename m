From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Mar 2014 10:15:47 +0200
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <532017B3.708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 28/02/14 14:20, Tomi Valkeinen wrote:
> Hi,
> 
> This series is a re-send of
> http://article.gmane.org/gmane.linux.drivers.devicetree/61739
> 
> I'm cc'ing more people, and I want to clarify the contents of the series:
> 
> While this has been developed for OMAP, only the first patch is about OMAP
> bindings. The rest are generic bindings for video components, which can be used
> on any platform.
> 
> The bindings use the V4L2 style video port/endpoint system, described in
> Documentation/devicetree/bindings/media/video-interfaces.txt, to connect the
> components. The same port/endpoint bindings are used by Philipp Zabel in his
> imx-drm patch series.

This series is a piece of bigger series, which brings DT support for
OMAP display subsystem. This uses the same V4L2 style ports/endpoints as
has been discussed recently regarding the series from Philipp. It
doesn't use the helper code from Philipp, but a custom one as Philipp's
code didn't exist when I made this, and also because I needed extra
functionality not present in Philipp's series (which aimed to just move
the current V4L2 code to a common place).

The main concerns with the ports/endpoints has been the optional 'port'
node for the case where we have a single endpoint, and the
double-linking of the endpoints.

If I remove the optional 'port' usage from my series, are you ok with me
proceeding with this series for 3.15, with the double-linked endpoints?

As far as I see, when we come to a conclusion how the linking should be
made, it's trivial to change the bindings in this series to match it,
even without needing any compatibility code. I just need to remove the
other link, and old dts files having double-linking will still work fine.

The reason I want to push this forward asap is that omap4 and omap5 are
already DT only, and for omap5 we don't have working display without DT
support for display. For omap4, we have a really hacky way to add
display support for a few boards, but that is causing major headaches
and I want to get rid of it.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/f3b90cfd/attachment-0001.sig>

From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 20 Apr 2012 14:38:43 +0200
Subject: [PATCH 3/7] DRM: add sdrm layer for general embedded system
 support
In-Reply-To: <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
References: <1334158428-23735-1-git-send-email-s.hauer@pengutronix.de>
 <1334158428-23735-4-git-send-email-s.hauer@pengutronix.de>
 <CAPM=9twdGXNU7kkOnx2GCmofE3KSohdeyuT1dVhvVHTtGA-Ysw@mail.gmail.com>
Message-ID: <20120420123842.GA25662@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Airlie wrote:
> I get the feeling the drm can just be a virtual platform device of
> some sort, then it reads the device tree and binds all the information
> on what crtc/encoders are available,

That's pretty much what I've come up with in the second round of Tegra DRM
patches. Basically display controllers and outputs (RGB, HDMI, TVO, DSI) get
separate drivers and register themselves with the DRM driver which then looks
at the device tree to see which display controllers to register as CRTCs and
parses a list of connector nodes to create encoder/connector pairs that
define the physical connectors and their corresponding outputs.

I did take a brief look at the SDRM patches as well and they didn't quite
seem to fit what was needed for Tegra. But if time allows I'll take a closer
look.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/704fc456/attachment.sig>

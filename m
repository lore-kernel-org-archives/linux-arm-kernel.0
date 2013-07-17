From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 10:57:08 +0100
Subject: [PATCH 2/3] ASoC: hdmi-codec: enable OF support
In-Reply-To: <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
 <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
Message-ID: <20130717095708.GG22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 09:49:10AM +0100, Mark Rutland wrote:
> On Wed, Jul 17, 2013 at 07:12:15AM +0100, Barry Song wrote:

> > this makes users be able to add a hdmi-codec node in dts instead of
> > hardcoding a platform device in mach.

> Similarly to my comment on the first patch, I'm not sure this is the
> best way to wire this up to devicetree. Can this not be hung off of hdmi
> controller drivers?

This one is different to the BT case - as you say it's hanging off the
HDMI controller so the HDMI controller ought to enumerate it either as a
stub or by actually seeing a device.  The platform device is fine but
it's not something that should appear in the DT unless it's conveying
some information about what's connected there (eg, power supplies for
something soldered down on the board).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/2dca995c/attachment.sig>

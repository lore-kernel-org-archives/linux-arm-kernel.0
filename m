From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Nov 2014 17:47:09 +0000
Subject: [PATCH 1/3] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <CAD=FV=XpweHvcTsVTMBkv9g4+GxoO8WdngGhfVj0QnOwq3ASdQ@mail.gmail.com>
References: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>
 <1416246184-29071-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=Xkei_wxa3jWb8bPvuynbSyq4o=ezjVD0+e04aOPCAM+Q@mail.gmail.com>
 <546C6BD2.4020802@collabora.co.uk>
 <CAD=FV=XpweHvcTsVTMBkv9g4+GxoO8WdngGhfVj0QnOwq3ASdQ@mail.gmail.com>
Message-ID: <20141119174709.GF22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 09:19:13AM -0800, Doug Anderson wrote:

Please stop CCing my work address for upstream things.

> On Wed, Nov 19, 2014 at 2:07 AM, Javier Martinez Canillas

> > I see, I thought that it was a common practice in the mainline kernel
> > too since I saw that many board DTS currently have a spidev node:

> > $ git grep 'compatible = "spidev"' arch/arm/boot/dts/ | wc -l
> > 19

These are bugs.  The device tree should describe the hardware, spidev is
a Linux implementation detail.  Provide a compatible string for the
device that is there just as you would for any other device.

> OK.  Please don't take my comments as a NAK on this patch.  I should
> have done the same grep myself before sending--sorry.  I just
> remembered the old conversation and looked for that instead.

Please take this as one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/57aa3249/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Aug 2013 11:34:03 +0100
Subject: [PATCH] ARM: dts: Enable USB hub on Arndale
In-Reply-To: <CAHbNUh2WTiRtvvUnqa7NSvRgZ22XdaEMb57w2umF5Jfhf_yohg@mail.gmail.com>
References: <1376474314-32491-1-git-send-email-broonie@kernel.org>
 <CAHbNUh2WTiRtvvUnqa7NSvRgZ22XdaEMb57w2umF5Jfhf_yohg@mail.gmail.com>
Message-ID: <20130814103403.GO6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 04:00:16PM +0530, Tushar Behera wrote:
> On 14 August 2013 15:28, Mark Brown <broonie@kernel.org> wrote:

> > +       usb at 12110000 {
> > +               usb-phy = <&usb2_phy>;
> > +       };

> ehci-s5p driver doesn't use 'usb-phy' property to find the PHY driver,
> hence this is not required.

I added that for documentation since it is actually what gets used - the
obvious way of handing this is for the hub to be treated like a PHY but
that doesn't work since we actually need the built in PHY to talk to the
hub.  Though I did mean it to be a separate patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/ca31e70b/attachment.sig>

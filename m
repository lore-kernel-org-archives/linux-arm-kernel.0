From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jun 2014 00:04:07 +0200
Subject: [PATCH v14 08/10] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <20140624235639.487429ad@e6520eb>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-8-git-send-email-denis@eukrea.com>
 <20140624214926.GA30039@mithrandir>
 <20140624235639.487429ad@e6520eb>
Message-ID: <20140624220404.GA30155@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 11:56:39PM +0200, Eric B?nard wrote:
> Hi Thierry,
> 
> Le Tue, 24 Jun 2014 23:49:37 +0200,
> Thierry Reding <thierry.reding@gmail.com> a ?crit :
> 
> > On Mon, Jun 16, 2014 at 12:11:22PM +0200, Denis Carikli wrote:
> > [...]
> > > diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-svga.txt
> > [...]
> > > @@ -0,0 +1,7 @@
> > > +Eukrea DVI-SVGA (800x600 pixels) DVI output.
> > [...]
> > > diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt
> > [...]
> > > @@ -0,0 +1,7 @@
> > > +Eukrea DVI-VGA (640x480 pixels) DVI output.
> > 
> > DVI outputs shouldn't be using the panel framework and this binding at
> > all. DVI usually has the means to determine all of this by itself. Why
> > do you need to represent this as a panel in device tree?
> > 
> because on this very simple display board, we only have DVI LVDS signals
> without the I2C to detect the display.

That's unfortunate. In that case perhaps a better approach would be to
add a video timings node to the device that provides the DVI output?

The panel bindings are really for internal panels and should define all
of their properties. That's also why they need a specific compatible
string.

What the above two bindings define are really "connectors" with a fixed
resolution rather than panels.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/157429d0/attachment.sig>

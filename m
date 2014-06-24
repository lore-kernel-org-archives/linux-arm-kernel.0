From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Jun 2014 23:56:48 +0200
Subject: [PATCH v14 08/10] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <CAL_JsqLbzS9Zh+NK8pfqJ=twQpz0qYfyH4xC3NnvCXBokyx+yQ@mail.gmail.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-8-git-send-email-denis@eukrea.com>
 <20140624150600.GT32514@n2100.arm.linux.org.uk>
 <CAL_JsqLbzS9Zh+NK8pfqJ=twQpz0qYfyH4xC3NnvCXBokyx+yQ@mail.gmail.com>
Message-ID: <20140624215647.GA30143@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 02:52:11PM -0500, Rob Herring wrote:
> On Tue, Jun 24, 2014 at 10:06 AM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
[...]
> > On Mon, Jun 16, 2014 at 12:11:22PM +0200, Denis Carikli wrote:
[...]
> >> diff --git a/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt b/Documentation/devicetree/bindings/panel/eukrea,mbimxsd51-dvi-vga.txt
[...]
> >> @@ -0,0 +1,7 @@
> >> +Eukrea DVI-VGA (640x480 pixels) DVI output.
> >> +
> >> +Required properties:
> >> +- compatible: should be "eukrea,mbimxsd51-dvi-vga"
> >> +
> >> +This binding is compatible with the simple-panel binding, which is specified
> >> +in simple-panel.txt in this directory.
> 
> Seems like we could just have a list of compatible strings rather than
> a mostly duplicated file.

We've been doing it this way for all other panels.

> >> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> >> index a251361..adc40a7 100644
> >> --- a/drivers/gpu/drm/panel/panel-simple.c
> >> +++ b/drivers/gpu/drm/panel/panel-simple.c
> >> @@ -403,6 +403,80 @@ static const struct panel_desc edt_etm0700g0dh6 = {
> >>       },
> >>  };
> >>
> >> +static const struct drm_display_mode eukrea_mbimxsd51_cmoqvga_mode = {
> >> +     .clock = 6500,
> >> +     .hdisplay = 320,
> >> +     .hsync_start = 320 + 38,
> >> +     .hsync_end = 320 + 38 + 20,
> >> +     .htotal = 320 + 38 + 20 + 30,
> >> +     .vdisplay = 240,
> >> +     .vsync_start = 240 + 15,
> >> +     .vsync_end = 240 + 15 + 4,
> >> +     .vtotal = 240 + 15 + 4 + 3,
> >> +     .vrefresh = 60,
> >> +     .pol_flags = DRM_MODE_FLAG_POL_PIXDATA_NEGEDGE |
> >> +                  DRM_MODE_FLAG_POL_DE_LOW,
> 
> Why aren't you using:
> 
> Documentation/devicetree/bindings/video/display-timing.txt

Because it's redundant information. We need to have a compatible for the
panel in the device tree anyway and that already implicitly defines the
display mode.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140624/15203d17/attachment.sig>

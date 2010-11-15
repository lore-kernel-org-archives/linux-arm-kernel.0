From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Mon, 15 Nov 2010 11:16:43 +0200
Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
In-Reply-To: <AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
References: <1289322724-20998-1-git-send-email-bryan.wu@canonical.com>
	<1289322724-20998-2-git-send-email-bryan.wu@canonical.com>
	<1289399707.3297.250.camel@tubuntu>
	<AANLkTimt+rZ3nTHK01VciYyh-pKMiCmLZYcJjqz6OTY8@mail.gmail.com>
Message-ID: <1289812603.2668.5.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-11-14 at 02:42 +0100, ext Bryan Wu wrote:
> On Wed, Nov 10, 2010 at 10:35 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > On Tue, 2010-11-09 at 18:12 +0100, ext Bryan Wu wrote:
> >> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
> >> will match the panel name which is passed from platform data and setup the
> >> right configurations.
> >>
> >> With generic DPI panel driver, we can remove those 4 duplicated panel display
> >> drivers. In the future, it is simple for us just add new panel configuration
> >> date in panel-generic-dpi.c to support new display panel.
> >
> > This is looking good, but still a couple of comments inline:
> >

<snip>

> > I think otherwise the patches look good. At some point we should add
> > backlight support also, so that we can remove a few drivers more (and
> > get rid of the extra backlight stuff in omap_dss_device struct).
> >
> 
> Yeah, I plan to do that. But IMHO, how about just move those backlight
> support as backlight drivers and only remain display control in this
> directory.

Hmm, yes, perhaps that would work for these DPI panels.

The reason I originally put the backlight driver inside the panel driver
is that there are many panels for which the backlight is a part of the
panel, in the sense that the backlight is controlled by sending messages
to the panel. For these the backlight needs to be somewhat integrated
into the panel driver.

 Tomi

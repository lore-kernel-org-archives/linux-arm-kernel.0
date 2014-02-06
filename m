From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Feb 2014 15:24:45 +0900
Subject: [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
In-Reply-To: <CANqRtoSubhvfgzn590k9oePLv04V00Z7aEuKw2Ofxi8FeCObbA@mail.gmail.com>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231019.22655.41456.sendpatchset@w520>
 <1397857.qyLQY9XTlp@avalon>
 <CANqRtoSubhvfgzn590k9oePLv04V00Z7aEuKw2Ofxi8FeCObbA@mail.gmail.com>
Message-ID: <20140206062442.GA17591@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Fri, Jan 31, 2014 at 12:10:05PM +0900, Magnus Damm wrote:
> Hi Laurent,
> 
> On Fri, Jan 31, 2014 at 10:17 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Magnus,
> >
> > Thank you for the patch.
> >
> > On Thursday 30 January 2014 08:10:19 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Create a new group for the USB0 OVC/VBUS pin by itself. This
> >> allows us to monitor PWEN as GPIO on the Lager board.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |    9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> --- 0001/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> >> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7790.c 2014-01-24
> > 10:23:32.000000000
> >> +0900 @@ -3231,6 +3231,13 @@ static const unsigned int usb0_pins[] =
> >>  static const unsigned int usb0_mux[] = {
> >>       USB0_PWEN_MARK, USB0_OVC_VBUS_MARK,
> >>  };
> >> +static const unsigned int usb0_ovc_vbus_pins[] = {
> >> +     /* OVC/VBUS */
> >> +     RCAR_GP_PIN(5, 19),
> >> +};
> >> +static const unsigned int usb0_ovc_vbus_mux[] = {
> >> +     USB0_OVC_VBUS_MARK,
> >> +};
> >
> > Another option would have been to split the existing usb0 group in usb0_pwen
> > and usb0_ovc. I'm not sure which is better though, I'd just like to know if
> > you had given it a thought.
> 
> I actually did just that in my first local attempt, but I decided not
> to since it will only cause potential breakage.
> 
> > Regardless, what about naming the new group usb0_ovc instead of usb0_ovc_bus
> > to keep names short ?
> 
> Is there any particular reason why you want shorter names?
> 
> >From my side, I prefer to keep the names in sync with the data sheet.
> In this particular case it is a shared pin so OVC is used for Host
> while VBUS is used for gadget, so if you're proposing to ditch VBUS
> then this feels somewhat inconsistent with the current gadget use
> case. =)

Hi Laurent,

I would like to move this patch forwards somehow.
If you are happy with it as-is could you consider merging it?
Otherwise, could you let me know what changes you would like made
so I can see about making it so?

Thanks

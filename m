From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 10 Oct 2017 10:25:16 -0700
Subject: [PATCH] arm64: dts: rockchip: enable touchpad button for
 rk3399-gru-kevin
In-Reply-To: <20171010170355.GA136735@google.com>
References: <20171009184028.11829-1-kernel@esmil.dk> <4174027.Z5MyPRUDcj@phil>
 <CANBLGcx187QrX3pgUAjvBmPbyJsX7ZiYdWXhamM-atEe+Mqe3A@mail.gmail.com>
 <20171010170355.GA136735@google.com>
Message-ID: <20171010172516.GA1681@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 10:03:57AM -0700, Brian Norris wrote:
> + Dmitry, who can probably answer better than I can
> 
> On Tue, Oct 10, 2017 at 01:04:20PM +0200, Emil Renner Berthing wrote:
> > On 10 October 2017 at 11:33, Heiko Stuebner <heiko@sntech.de> wrote:
> > > Am Montag, 9. Oktober 2017, 20:40:28 CEST schrieb Emil Renner Berthing:
> > >> Adding the linux,gpio-keymap entry also has
> > >> the side-effect of making the driver register
> > >> the touchpad as a touchpad rather than another
> > >> touchscreen.
> > >>
> > >> The index for BTN_LEFT was found by trial and error.
> > >>
> > >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > >
> > > looks good to me. I'll just give the ChromeOS people a chance to
> > > respond before applying [maybe they can even tell what the other
> > > keys are :-) ]

They are not connected.

> > 
> > Good plan. As far as I can tell their kernel doesn't send anything but
> > BTN_LEFT either. It's just that the controller supports multiple
> > buttons, but not all are necessarily connected to any button.
> > Their version of the driver has logic to detect the proper keymap
> > whereas the mainline driver gets it from this devicetree entry.
> 
> I believe Emil is mostly correct. We only are using a BTN_LEFT in our
> copy of the driver, and I'm not sure the others are connected to
> anything. As Dmitry has explained to me (when I also wondered about
> "detect[ing] the proper keymap"), we don't exactly "auto"discover
> things; we just heuristically determine the configurations we know are
> used on Chrome devices.

Right, we had a "legacy" GPIO/button mapping on original Pixels that
used T9 multitouch reports, then we switched to a bit different mapping
for newer devices that use T100 multitouch reports.

We should really have explicit map, like we have in upstream driver.

> 
> So from the sound of it, this keymap property is reasonable. I haven't
> actually checked what our driver "auto" detects on gru-kevin, but if
> this works then I'll bet it's correct :)
> 
> IOW, I don't know enough to ACK this patch, but I'm certainly not going
> to NAK it.

I think I can ACK it:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

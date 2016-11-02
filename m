From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 2 Nov 2016 09:22:06 +0100
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
In-Reply-To: <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd>
 <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
Message-ID: <20161102082206.GE21488@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> >> Better then previous one.
> >> >>
> >> >> But my version of bq27xxx_battery.c already contains this:
> >> >
> >> > This is for allowing udev rule to set the properties as well.
> >> > otherwise a kinda crude RUN = " echo value >
> >> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
> >>
> >> Any thoughts on this?
> >
> > I'd say  echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval .. is quite
> > adequate solution...?
> >
> > Alternatively, convince us that something else is useful for everyone,
> > and we can do the right thing (poll more often when battery is nearly
> > empty), automatically...
> 
> Ok should have had the patchset set it per device, and not use the
> global poll_interval. Of need to add some logic to see if uses the
> global poll_interval or it's own setting.
> 
> There are times where you could have multiple batteries connected to
> multiple fuel gauges, and want to up the polling interval on certain
> ones that are discharging at different rates.
> 
> But of course I'll let you guys let me know if this seems useful at all.

I agree per-device polling would be cleaner.

But unless you have hardware with more than one bq27xxx, I'd avoid the
work...

Now... its also possible that poll_interval should change itself
(within kernel) to do the right thing.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/5f5fae4c/attachment.sig>

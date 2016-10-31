From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 31 Oct 2016 22:38:46 +0100
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
In-Reply-To: <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
Message-ID: <20161031213846.GA21014@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-10-31 13:22:18, Matt Ranostay wrote:
> On Tue, Oct 25, 2016 at 11:47 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> > On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> >>> Pavel + Sebastian this is the patchset that need I some input on :)
> >>
> >> Better then previous one.
> >>
> >> But my version of bq27xxx_battery.c already contains this:
> >
> > This is for allowing udev rule to set the properties as well.
> > otherwise a kinda crude RUN = " echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
> 
> Any thoughts on this?
 
I'd say  echo value >
/sys/module/bq27xxx_battery/parameters/poll_interval .. is quite
adequate solution...?

Alternatively, convince us that something else is useful for everyone,
and we can do the right thing (poll more often when battery is nearly
empty), automatically...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161031/bb28809e/attachment.sig>

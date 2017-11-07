From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 7 Nov 2017 21:16:51 +0100
Subject: Battery charging, battery status on Nokia N9, N950
In-Reply-To: <CAOf5uwnoUkZG6KUzhn2u8vdcd5_+nmUQpXwE1zjNwiakN+Mscg@mail.gmail.com>
References: <20171103210349.GA14071@amd> <20171107195020.GA19508@amd>
 <20171107195912.GA3274@amd>
 <CAOf5uwnoUkZG6KUzhn2u8vdcd5_+nmUQpXwE1zjNwiakN+Mscg@mail.gmail.com>
Message-ID: <20171107201651.GB2572@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-11-07 21:04:19, Michael Nazzareno Trimarchi wrote:
> Hi Pavel
> 
> On Tue, Nov 7, 2017 at 8:59 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >>
> >> > I'm fighting with battery status & battery charging on Nokia
> >> > N9/N950. https://elinux.org/N950 contains enough info to get battery
> >> > status (and below is first attempt at kernel implementation), but I'm
> >> > not sure what needs to be done to charge the battery (or at least
> >> > power phone from USB).
> >>
> >> Nemo recovery system (2824336 Jul 25  2016 zImage-moslo) seems to
> >> either charge phone from USB or at power it from USB.
> >>
> >> But 4.13 does not; it seems there are two separate issue.
> >>
> >> First, something needs to be done to enable system power from the
> >> USB. I'm not sure what that one would be :-(. Then, it should be
> >> possible to ask bq24153 to charge the battery.
> >
> > If someone has schematics or pointer to them.. for N9 or N950, that
> > would be useful :-).
> >
> 
> You can dump pinctrl and configuration and check if some gpio are
> used.  From reference schematic of this charger you have OTG and
> CD. Those pins can be just used to enable/disable and boost charging.
> You should dig a bit in sysfs to figure it out ;)

I tried to search old board file from working version -- seemed better
than randomly toggling stuff in /sys. But I could not find anything
suspicious.

If someone has the schematics, that would be useful.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/b8c1c535/attachment.sig>

From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Nov 2017 22:46:18 +0100
Subject: Display on Nokia N950 was Re: Serial cable N9
In-Reply-To: <2851c57a-7aba-ddab-3201-03d91fdfa040@gmail.com>
References: <20171029082331.GA4358@amd>
 <b05ead6d-3996-3bfc-8f09-09d0229a79b3@gmail.com>
 <20171030074816.GA31977@amd>
 <1cbe2c73-754d-f0c5-1732-b306c7f86f85@gmail.com>
 <20171030205232.GA28601@amd>
 <0f4b8908-7421-6481-8415-3563f347b9de@gmail.com>
 <d3682a85-7910-78fc-407d-fdd333a1d60f@gmail.com>
 <50c15c96-36f5-1e1b-0538-9c758919141c@gmail.com>
 <20171101193220.GA14009@amd>
 <2851c57a-7aba-ddab-3201-03d91fdfa040@gmail.com>
Message-ID: <20171101214618.GB1636@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > For the record, display does not work for me in 4.14 on either n9 or
> > n950. I did not investigate that, yet.
> 
> On v4.13 framebuffer console works OK (I haven't tested anything more in
> fact), but somewhere between v4.13 and v4.14-rc1 there is a commit that
> breaks things - my best guess at this time after a partial git bisect is
> that 906dde0f355bd97c080c215811ae7db1137c4af8 is the one to look at.

Confirmed. Reverting the merge (as far as it can be reverted) gets me
booting N950 with working display. (With 906dde applied, backlight
goes turns on, so it looks like display driver is initialized, but
then machine is killed, probably by watchdog).

AFAICT N950 display never worked on mainline; I'm using Sebastian's
patches to get it to work.

Linux n900 4.14.0-rc7-28884-gdf7c8f0-dirty #283 Wed Nov 1 22:31:35 CET
2017 armv7l GNU/Linux

Filip did all the work here, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171101/3486b3ec/attachment.sig>

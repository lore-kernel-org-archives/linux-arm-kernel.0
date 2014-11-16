From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Nov 2014 09:38:31 +0100
Subject: dtb size limit? was Re: Tiny dts change breaks boot on n900
In-Reply-To: <5460D8F4.9000507@suse.de>
References: <20141110123118.GA31134@amd> <20141110125806.GA16650@amd>
 <5460D8F4.9000507@suse.de>
Message-ID: <20141116083831.GB30646@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2014-11-10 15:25:40, Andreas F?rber wrote:
> Am 10.11.2014 um 12:58 schrieb Pavel Machek:
> > If I replace the blo[ck] below with
> > 
> >  a = <1>;
> >  b = <2>;
> >  c = <3>;
> >  d = <4>;
> > 
> > Resulting kernel boots. Replacing it with
> > 
> >  a-really-long-attribute-name-hopefully-this-breaks-stuff = <1>;
> >  b = <2>;
> >  c = <3>;
> >  d = <4>;
> > 
> > Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
> > dtb is 68910 bytes.
> 
> Did you verify that your initrd, if any, does not overlap the end of the
> kernel when loading it from the bootloader?

I don't use initrd, so this can't be it. Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

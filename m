From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 25 Jan 2017 12:12:33 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <20170124184526.GA25056@roeck-us.net>
References: <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
Message-ID: <20170125111233.GB3912@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > >>Right.
> > > >>
> > > >>Before reverting, can you please try if this patch works or not?
> > > >
> > > >Not really. Revert now. Sorry.
> > > >
> > > >Are you sure? This does not look equivalent to me at all.
> > > >
> > > >"name" file handling moved from drivers to the core, which added some
> > > >crazy checks what name can contain. Even if this "works", what is the
> > > >expected effect on the "name" file?
> > > >
> > > The hwmon name attribute must not include '-', as documented in
> > > Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> > > Maybe in your world, but not in mine.
> > 
> > Well, lets revert the patch and then we can discuss what to do with
> > the "name" problem.

Ok, so the patch is on the way in. What to do next?

pavel at n900:/sys/class/hwmon$ cat hwmon0/name
bq27200-0
pavel at n900:/sys/class/hwmon$ cat hwmon1/name
rx51-battery

> To provide some detail: libsensors gets just as confused with wildcards
> and whitespace/newline as it does with '-' in the reported name, which
> is why those are blocked by the new API.

Ok... Question is "does someone actually use hwmon*/name on N900"? If
so, we can't change it, but it is well possible that noone is.

Next question is .. are there other drivers affected? Do we want to do
'-' -> '_' in the core or somewhere in the drivers? We might want to
do the change in early in 4.11 and see what breaks....

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/3056248c/attachment.sig>

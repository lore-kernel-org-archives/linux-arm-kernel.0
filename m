From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 24 Jan 2017 18:58:01 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
References: <20170123124058.GA17134@amd> <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
Message-ID: <20170124175800.GA15070@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>Right.
> >>
> >>Before reverting, can you please try if this patch works or not?
> >
> >Not really. Revert now. Sorry.
> >
> >Are you sure? This does not look equivalent to me at all.
> >
> >"name" file handling moved from drivers to the core, which added some
> >crazy checks what name can contain. Even if this "works", what is the
> >expected effect on the "name" file?
> >
> The hwmon name attribute must not include '-', as documented in
> Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> Maybe in your world, but not in mine.

Well, lets revert the patch and then we can discuss what to do with
the "name" problem.

Unfortunately, code enforces different rules than documentation says,
and it is all visible to userspace.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/c7c57cea/attachment.sig>

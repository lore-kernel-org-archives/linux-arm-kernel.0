From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 12:09:47 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
References: <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
Message-ID: <20170127110947.GA5335@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >If this is the case, you'd better set
> >(struct thermal_zone_params)->no_hwmon when registering the thermal
> >zone device, in which case, the hwmon device will not be created.
> >
> >In fact, I'd prefer to change tzp->no_hwmon to tzp->hwmon to not create
> >hwmon I/F by default, and see if there is anyone using it. If yes, we
> >can set the flag in soc thermal driver, explicitly, at meantime, a
> >hwmon compatible name is required.
> >
> >But one foreseeable result is that we may get bug reports from end user
> >that some sensors (acpitz, etc) are gone in 'sensors' output. And TBH,
> >I'm not quite sure if this can be counted as a regression or not.
> >
> 
> That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> the ABI Police, but taking the entire device away is ok.

Stop trying to break other people's systems. Thanks you.



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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/001533da/attachment.sig>

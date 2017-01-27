From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 12:16:26 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
References: <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
Message-ID: <20170127111626.GB5335@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> >>the ABI Police, but taking the entire device away is ok.

Changing bq27200-0 to bq27200_0 is forbidden in -rc6 time. If you
believe noone depends on the name, argue your case, and it might be
possible to change it in -rc0.

If someone uses the name, they care about the device, and you can't
take it away.

> >No. IMO, it depends on if the interface is used or not.
> >If hwmon I/F is used, we can not take it away, nor change its name.
> 
> Even if the use doesn't depend on that name ?

If the use doesn't depend on the name, you may get away with changing
the name. (But not in -rc6.)

> >If thermal zone I/F is used, we can not change it's 'type' name to be
> >compatible with new hwmon API.
> 
> You mean you can not fix the name to be compatible with libsensors.
> 
> Makes me wonder if there shouldn't be a rule that exploits must not
> be fixed if already exploited.

That is not useful argumentation.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/acb177c3/attachment-0001.sig>

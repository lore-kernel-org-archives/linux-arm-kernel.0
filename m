From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 20:29:09 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <1485528033.2469.61.camel@intel.com>
References: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <1485528033.2469.61.camel@intel.com>
Message-ID: <20170127192909.GD20571@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > That sounds like fun. Changing bq27200-0 to bq27200_0 is
> > > > Forbidden by
> > > > the ABI Police, but taking the entire device away is ok.
> > > > 
> > > No. IMO, it depends on if the interface is used or not.
> > > If hwmon I/F is used, we can not take it away, nor change its name.
> > Even if the use doesn't depend on that name ?
> > 
> when I said "the interface is used", I mean the name string is used.
> > > 
> > > If thermal zone I/F is used, we can not change it's 'type' name to
> > > be
> > > compatible with new hwmon API.
> > > 
> > You mean you can not fix the name to be compatible with libsensors.
> > 
> 
> We can try to convert it to a libsensor-compatible string, either for
> hwmon only, or for both thermal and hwmon. But this is an ABI change,
> right?
> And my understanding about the ABI change is that, if no one cares
> about it, we're okay, or else, this is a regression, and we need to
> fall back to the previous ABI immediately. In order to change it in a
> long run, we need to make a note in Documentation/ABI/, and change it
> sometime in the future (a couple of release cycles or even more).

If no one cares, you can get away with the change. So I guess that's
what we should try. In -rc1. We should _not_ do "this changes in 2
years" dance, as that would increase chance for someone to use the old
name.

So I guess changing to libsensor-compatible name in v4.11-rc0 (maybe
with note in the ABI documenation) is the best plan. If someone
complains, we'll have to revert and think about something else.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/e9ed2a62/attachment-0001.sig>

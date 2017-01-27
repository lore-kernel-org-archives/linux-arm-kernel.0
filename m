From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 20:12:47 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <20170127172039.GA2498@roeck-us.net>
References: <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <1485528033.2469.61.camel@intel.com>
 <20170127172039.GA2498@roeck-us.net>
Message-ID: <20170127191247.GC20571@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-01-27 09:20:39, Guenter Roeck wrote:
> On Fri, Jan 27, 2017 at 10:40:33PM +0800, Zhang Rui wrote:
> > > > 
> > > > If thermal zone I/F is used, we can not change it's 'type' name to
> > > > be
> > > > compatible with new hwmon API.
> > > > 
> > > You mean you can not fix the name to be compatible with libsensors.
> > > 
> > 
> > We can try to convert it to a libsensor-compatible string, either for
> > hwmon only, or for both thermal and hwmon. But this is an ABI change,
> > right?
> 
> Let's go back to the basics.
> 
> Fact is that the thermal subsystem registers hwmon devices with 'name'
> attributes which violate the documented hardware monitoring ABI.
> I think we can consider this undisputed.
> 
> The rest is pretty much all opinion.
> 
> Is a change in a driver to stop violating a documented ABI an ABI change
> or a bug fix ? In other words, does a driver violating a documented ABI
> make that ABI violation part of the ABI ?

It can be both. But "no regressions" takes precedence over
"documentation".

> Quite interesting questions. My take is that it is a bug fix, others
> apparently have the strong opinion that potential users of such an ABI
> violation have priority, and that a violation of a documented ABI _does_
> make this violation part of the ABI.

"Potential" users you can work around. "Real" users are problem.

And yes, I have strong opinion about release candidates. Outside that,
see my next mail.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/45c7f31f/attachment.sig>

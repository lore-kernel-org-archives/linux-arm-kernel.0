From: nm@ti.com (Nishanth Menon)
Date: Tue, 4 Feb 2014 13:28:20 -0600
Subject: Extending OPP bindings
In-Reply-To: <20140204182220.GQ22609@sirena.org.uk>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
 <20140131180929.GH2616@e102568-lin.cambridge.arm.com> <52F12AE7.904@ti.com>
 <20140204182220.GQ22609@sirena.org.uk>
Message-ID: <52F13F54.5060000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 12:22 PM, Mark Brown wrote:
> On Tue, Feb 04, 2014 at 12:01:11PM -0600, Nishanth Menon wrote:
> 
>> As long as the key to the data sets are all the same (frequency),
>> information in data set #0 is maintained. It would be in our common
>> long term interest to maintain the split.
> 
> You're assuming that the frequency is a unique key here.  That may not
> be the case, for example two OPPs might have the same CPU clock
> (assuming that's the frequency you're referring to) but different bus
> clocking and of course the CPUs or CPU clusters might be individually
> scalable (this is common in big.LITTLE designs I think).
> 
Which is why OPPs are maintained per device, bus OPPs belong to bus
device (in TI terminology, we'd be talking of cross domain dependency
here for maintaining asynchronous bridge timing closure constraints -
but ofcourse, other SoCs may or maynot have such constraints). For
scaling bus frequency, we already have infrastructure in place - clock
notifiers - discussion of using that is much deeper topic of it's own.

for each processor that is uniquely transitioning, we'd have it's own
sets of OPPs - the correct representation of the device node is the
key there.

-- 
Regards,
Nishanth Menon

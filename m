From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 14:11:45 +0100
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <20161019094227.GB1461@amd>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
 <20161018104539.GB15639@leverpostej> <20161019094227.GB1461@amd>
Message-ID: <20161019131145.GA11036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 11:42:27AM +0200, Pavel Machek wrote:
> On Tue 2016-10-18 11:45:39, Mark Rutland wrote:

> Either the lowlevel suspend code is stable and bug free, and then
> having that code is not a problem.

This ignores the cost of maintaining that code. Kernel APIs change over
time, and no code is ever completely stable, even if at one point in
time it happens to be bug-free.

> Or the lowlevel suspend code is complex enough to contain some bugs,
> and in such case it is better to debug and update it with kernel.

It is better for that code to be debuggable and updateable. That is not
the same as being part of the kernel.
 
> > ARM publishes and maintains the ARM Trusted Firmware [1], which anyone
> > can use and build atop of. It's open source (three-clause BSD with DCO),
> > and accepts board ports. You can have a completely open stack,
> > regardless of whether part of that stack is firmware.
> 
> If something is called "Trusted", it is not trustworthy.

Certainly we shouldn't blindly trust anything.

I object to ATF being called "not trustworthy"; the aims of the project
are certainly not dishonest.

> BSD is better than closed source, but it also means that you will not
> get the sources from your hw vendor.

That depends on your hardware vendor, as always. There are a number of
platform ports in the upstream ATF repo.

It's also worth considering that a number of 32-bit arm parts require
closed firmware (as far as I can tell, including the N900).

> Being separate module means it will be never updated.

That's certainly not true as a blanket statement. The Juno FW (including
an open-source UEFI!) is periodically updated, and mechanisms like
UpdateCapsule() should make this easier in future.

> Being separate module means it will be hard to debug, in area where
> debugging is already pretty hard.

It can be harder, yes. There are also benefits, given the same code can
be tested on a variety of platforms.

> Can it do advanced stuff like deep powersaving on N900 idle?

Sorry, I don't know precisely what you're referring to.

It can do things like shutting down entire CPU clusters (and IIRC
associated interconnect) when all relevant CPUs are idle, if that's what
you mean.

Thanks,
Mark.

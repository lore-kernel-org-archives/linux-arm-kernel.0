From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Feb 2011 18:53:04 -0000
Subject: [RFC PATCH] ARM: pmu: add OF match support
In-Reply-To: <AANLkTin5aA0tq-PYBmRKh6tLv6bHRaK5ymjhsj9T4-Ah@mail.gmail.com>
References: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
	<AANLkTi=7azYw8+sYrbDsLOfF1aZynBDo+ub37O9j+k49@mail.gmail.com>
	<3399156206431206254@unknownmsgid>
	<AANLkTin5aA0tq-PYBmRKh6tLv6bHRaK5ymjhsj9T4-Ah@mail.gmail.com>
Message-ID: <002801cbc88a$95555270$bffff750$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

> > Following on from Rob's update, it would be nice if you could specify that
> > the PMU is a CPU PMU (as opposed to L2-cache, bus, gpu etc) in the string.
> > That way adding different PMUs in the future seems more natural and it accounts
> > for your concerns above. Is that ok, or does the compatible string have to
> > match that used by the platform bus?
> 
> It does make sense to encode the specific implementation into the
> compatible string.  A single device driver can bind against multiple
> compatible strings.  ie. the match table could include {.compatible =
> "arm,cortex-a9-pmu"},{.compatible = "arm,cortex-a9-l2cache-pmu"}...

Ok - that's great! Specifying the CPU is probably a little verbose, but
something like "arm,armv7pmu" would be really helpful when it comes to
multiple devices.

> > As for versioning, the PMU detection is done dynamically at runtime,
> > so knowing that we're poking a CPU is enough.
> 
> Fair enough.  It is still good practice in the compatible list to
> encode the specific PMU implementation (maybe arm,cortex-a9-pmu?)
> instead of trying to define a 'generic' or wildcard compatible value.
> Newer implementations can always claim compatibility with an older
> implementation so that the kernel doesn't have to be modified to find
> the new devices.  "arm,pmu" is probably too generic.

"arm,pmu" is definitely too generic. If it's good practice to specify
as much as possible, then go for it - I just feel a little uneasy having
to add lots of redundant kernel code but it sounds like you'll hopefully
prove me wrong on that :)

Cheers,

Will

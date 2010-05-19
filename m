From: imp@bsdimp.com (M. Warner Losh)
Date: Wed, 19 May 2010 11:32:01 -0600 (MDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <AANLkTinzTKkSIwGemGJ-gI0DSD-ANOSePkdwFZhMwFnM@mail.gmail.com>
References: <AANLkTinsOSI_TIc7Jyy4QFuFaS2d-fi0y3LMuITLyG3N@mail.gmail.com>
	<20100519164534.GE1693@shareable.org>
	<AANLkTinzTKkSIwGemGJ-gI0DSD-ANOSePkdwFZhMwFnM@mail.gmail.com>
Message-ID: <20100519.113201.411418020318963143.imp@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In message: <AANLkTinzTKkSIwGemGJ-gI0DSD-ANOSePkdwFZhMwFnM@mail.gmail.com>
            Grant Likely <grant.likely@secretlab.ca> writes:
: > ?They could also settle on a
: > fixed R1 value meaning "devtree platform".
: >
: > Or if a fixed "devtree platform" R1 is used, R2 could point directly
: > at the DT, no atag list in that specific case.
: 
: My sticking point is I want there to be exactly one method of passing
: the device tree blob.  I don't see any advantage in having more than
: one mechanism for passing the dtb pointer.  Whether it be ATAG or bare
: DT pointer, we should be able to choose a single method now that is
: suitable for the foreseeable future.

The gain from having a shortcut is small (maybe a dozen instructions
at most saved).  I'd rather see an interface compatible with old ATAG
boot loaders that would allow for easy selection, inside the kernel,
of which information to believe.

The biggest concern that I have with this is to make sure that it is
unambiguous what the kernel should do with the data.  Eg, the DT takes
precedence over the rest of the ATAG list, but the two are required to
be 100% consistent (with all the mappings between ATAG and DT well
defined).  The only time things should vary is when DT is more
expressive than ATAG, and even then kernels relying on the old
interface should do a sensible thing...

Warner

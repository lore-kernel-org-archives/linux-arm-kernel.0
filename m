From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 18:18:37 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
Message-ID: <20051.57581.894859.395981@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> There may be a safe way to do this check -- for example, on ARM1176
> and Cortex-A8 there is a CP14 debug status/control register that you can
> read which includes a flag indicating which world you're in.  This isn't part
> of the architecture though and may be different/not possible on some
> CPUs.

Yes.  I don't think we can write this into a boot protocol spec unless
we have some architectural way of doing it.

> All in all, it's better to engineer things so that the check doesn't need to
> be done at all.

Yes, in principle.

> Note that in real deployments, the kernel is not an ELF image and
> therefore cannot have notes.

Yes.  But in the future it will do, surely ?  I mean, we're working on
bootloader protocols and this part (to do with startup cpu states and
ownership of the various privilege levels) is only part of it.

Ian.

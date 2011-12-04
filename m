From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 05 Dec 2011 09:41:55 +1100
Subject: [PATCHv5] atomic: add *_dec_not_zero
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <20111204213316.GB14542@n2100.arm.linux.org.uk>
 <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
 <20111204221850.GC14542@n2100.arm.linux.org.uk>
Message-ID: <1323038515.11728.26.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:

 .../...

> And really, I believe it would be a good cleanup if all the standard
> definitions for atomic64 ops (like atomic64_add_negative) were also
> defined in include/linux/atomic.h rather than individually in every
> atomic*.h header throughout the kernel source, except where an arch
> wants to explicitly override it.  Yet again, virtually all architectures
> define these in exactly the same way.
> 
> We have more than enough code in arch/ for any architecture to worry
> about, we don't need schemes to add more when there's simple and
> practical solutions to avoiding doing so if the right design were
> chosen (preferably from the outset.)
> 
> So, I'm not going to offer my ack for a change which I don't believe
> is the correct approach.

I agree with Russell, his approach is a lot easier to maintain long run,
we should even consider converting existing definitions.

Cheers,
Ben.

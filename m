From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 15:52:08 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <loom.20140707T153253-384@post.gmane.org>
References: <20140701234800.GA23577@sirena.org.uk> <4473002.jGohFvPsvi@wuerfel>
 <7B049AD4-78F8-4494-A2CB-57DD346107DA@arm.com>
 <201407061739.22152.arnd@arndb.de>
 <loom.20140707T153253-384@post.gmane.org>
Message-ID: <20140707145208.GC32578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 01:59:54PM +0000, Janne Grunau wrote:
> Arnd Bergmann <arnd <at> arndb.de> writes:
> > but I don't see how we could emulate IT without anything
> > short of a full interpretation of user instructions from the kernel.
> 
> Avoiding deprecated forms of IT would be harder. It's used more often in
> libav (~50 times)

Is this explicitly written IT instructions or in generated code (gas,
gcc)?

> so it should be only disabled if it's emulated or not
> available using an explicit HWCAP. Not using Thumb for those functions would
> be another option for libav. Again this doesn't fix existing binaries and it
> doesn't fix compiled code.

As I said, I don't see this going away (easily). I've heard the
toolchain guys adding warnings but they don't help unless you rebuild
your code. Given the amount of IT instructions, I don't even propose
adding emulation/warnings to the kernel for the time being (that would
be step 1 in my "instruction deprecation" proposal, we have to think
about it; some trapping would be handy to to assess the impact but
still defaulting to native).

-- 
Catalin

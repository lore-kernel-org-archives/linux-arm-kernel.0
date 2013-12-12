From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 22:48:51 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386888245.25449.51.camel@sakura.staff.proxad.net>
References: <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk>
 <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk>
 <1386887402.25449.48.camel@sakura.staff.proxad.net>
 <20131212223626.GW4360@n2100.arm.linux.org.uk>
 <1386888245.25449.51.camel@sakura.staff.proxad.net>
Message-ID: <20131212224851.GY4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:44:05PM +0100, Maxime Bizon wrote:
> 
> On Thu, 2013-12-12 at 22:36 +0000, Russell King - ARM Linux wrote:
> 
> > Does this bug show up in existing unmodified mainline kernels?
> 
> not for me, I found this while writing new code.
> 
> though all possible kernel callers are not enabled in my .config.

Okay, as we have no reports so far of this affecting anything in any
mainline kernel, I think I'm going to queue the fix up for v3.14 and
not -rc - we know that although the assembly is not correct in the IP
code, we know that it's completely harmless there because the overflowed
byte is always zero.

So... I'll queue it for v3.14.  If anyone does find it affects existing
kernels, we can always apply it for -rc and stable kernels.

Thanks for your patience Maxime.

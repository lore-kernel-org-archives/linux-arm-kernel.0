From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu, 7 Mar 2013 07:17:42 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <20130307031707.GA25137@mudshark.cambridge.arm.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
 <20130305030436.GA18040@mudshark.cambridge.arm.com>
 <513596F2.1000701@gmail.com>
 <20130305080845.GA19097@mudshark.cambridge.arm.com>
 <1362475797.8941.67.camel@hastur.hellion.org.uk>
 <20130307031707.GA25137@mudshark.cambridge.arm.com>
Message-ID: <1362640662.8941.141.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-07 at 03:17 +0000, Will Deacon wrote:
> > I looked and couldn't see an existing 64 bit xchg, was I looking in the
> > wrong place? Ah, wait, I see atomic64_xchg now. But that needs an
> > atomic64_t while I have a xen_ulong_t (which == 64 bits on ARM). This is
> > a kernel<->hypervisor ABI so I can't just change it to an atomic64_t. I
> > suppose I could cast (see below, untested) but that seems rather icky.
> 
> You can play some container_of tricks, like we do in cmpxchg64 to get this
> right. Alternatively, we could look at an xchg8 implementation which some
> other architectures have (although they seem to be 64-bit machines).

I went with the container of trick + appropriate Kconfig depends and
sent a patch out a couple of seconds ago.

Thanks for your help/advice!

Ian.

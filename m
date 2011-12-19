From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 12:31:19 -0500 (EST)
Subject: [PATCH] ARM: net: JIT compiler for packet filters
In-Reply-To: <4EEEA644.5010008@gmail.com>
References: <1324252185-15894-1-git-send-email-mgherzan@gmail.com>
 <4EEEA644.5010008@gmail.com>
Message-ID: <alpine.LFD.2.02.1112191226160.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Dec 2011, Rob Herring wrote:

> On 12/18/2011 05:49 PM, Mircea Gherzan wrote:
> > +	select HAVE_BPF_JIT if (!THUMB2_KERNEL && AEABI)
> 
> No thumb2. That's a shame...

I think this would be more sensible to make a Thumb2 kernel properly 
interoperate with this and keep the JIT code simple rather than having 
to duplicate all this for Thumb2.

> BLX is v5+ only. It probably fine to make the JIT v5+ only. There's
> probably not much v4 h/w that would use this.

While you might be right, I don't think it is that big a cost to make 
this support ARMv4 too.  In fact, if slow ARMv4 systems are still 
routing packets out there, they are likely to see a huge benefit from 
this.


Nicolas

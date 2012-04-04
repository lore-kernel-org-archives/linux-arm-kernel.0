From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 04 Apr 2012 22:35:50 +0200
Subject: Handling device shared SFR on dt platform
In-Reply-To: <20120403160454.BDFF23E0598@localhost>
References: <4F6A5853.9090809@gmail.com>
 <20120324193200.822AD3E0B06@localhost> <4F736A4A.6050302@gmail.com>
 <20120403160454.BDFF23E0598@localhost>
Message-ID: <4F7CB0A6.7010809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2012 06:04 PM, Grant Likely wrote:
>> What concerns me, is an overhead from region request/ioremap(?)/release, 
>> just to access a single 32-bit register. I'm going to see if those accesses
>> could be moved to only device driver's probe() and remove() callbacks and 
>> what might be the resulting power consumption increase from that, if any.
> 
> Personally, I'd just create a shared function used by both drivers to
> access the register and protect it with a spinlock.  That way the
> region only needs to be mapped once, and the overhead is as low as
> possible.

Hmm, that's what I originally started with. I've just removed function 
callback from the platform data struct in favour of having the drivers 
using directly the function exported by plat-s5p. Then I started devising
something alternative, in hope to get rid of the drivers compilation 
dependency on PLAT_S5P. There seems little point in that though, since 
the chance to have those IP blocks available on other archs or ARM sub-archs,
than Samsung S5P/Exynos, are extremely low. 

I'll post finally some patches for review. Thank you.

---
Regards,
Sylwester

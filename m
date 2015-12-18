From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 18 Dec 2015 10:33:25 -0800
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <20151218111346.GF30483@arm.com>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
 <20151218111346.GF30483@arm.com>
Message-ID: <56745175.9010006@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/15 03:13, Will Deacon wrote:
> 
> From an implementation and performance point of view, this can certainly
> be used by arm64. My only concern is that we increase the region where
> PAN is disabled (that is, user accesses are permitted). Currently, that's
> carefully restricted to the single userspace access, but now it could
> easily include accesses to the kernel stack, perhaps even generated as
> a result of compiler spills.
> 
> I'm pretty unimaginative when it comes to security exploits, but that
> does sound worse than the current implementation from a security
> perspective.
> 

It is, but it is a tradeoff.  It is way better than opening it up for
the entire kernel.  In the end the only real way to avoid this is
compiler support, which I *have* discussed for x86 with the gcc people.
 gcc could avoid the back-to-back on and off and even batch accesses by
moving them into registers.

	-hpa

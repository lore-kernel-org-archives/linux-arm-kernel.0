From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Dec 2009 19:22:20 +0000
Subject: [PATCH] ARM: Add atomic64 routines for ARMv6k and above.
In-Reply-To: <1260555237-18825-1-git-send-email-will.deacon@arm.com>
References: <1260555237-18825-1-git-send-email-will.deacon@arm.com>
Message-ID: <20091211192220.GM4164@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 06:13:57PM +0000, Will Deacon wrote:
> In preparation for perf-events support, ARM needs to support atomic64_t
> operations. v6k and above support the ldrexd and strexd instructions to do
> just that.
> 
> This patch adds atomic64 support to the ARM architecture. v6k and above
> make use of new instructions whilst older cores fall back on the generic
> solution using spinlocks. If and when v7-M cores are supported by Linux, they
> will need to fall back on the spinlock implementation too.
Looks good! I've given this a go with the perf events code and it all looks
fine to me. Platform used was an ARM1176JZ-S (with K extensions).

Tested-By: Jamie Iles <jamie.iles@picochip.com>

Jamie

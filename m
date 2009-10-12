From: davem@davemloft.net (David Miller)
Date: Mon, 12 Oct 2009 02:37:44 -0700 (PDT)
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <20091012090710.GA29310@n2100.arm.linux.org.uk>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
Message-ID: <20091012.023744.157085851.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 12 Oct 2009 10:07:10 +0100

> On Mon, Oct 12, 2009 at 02:20:23PM +0530, Nitin Gupta wrote:
>> Same problem exists on mips too.
> 
> Nice catch.  This logic came from sparc64, so I think you'd want to talk
> to davem about it as well.
> 
> In the mean time, submitting your fix to the patch system would be great,
> thanks.

Sparc64 flushes unconditionally when there is no page mapping.
So, it should be fine here.

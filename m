From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 18:06:26 +0000
Subject: [PATCH 2/3] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20131212173912.GF3382@arm.com>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
 <1386792029-23148-2-git-send-email-broonie@kernel.org>
 <20131212113512.GC28621@e103034-lin>
 <20131212120649.GB5367@sirena.org.uk>
 <20131212133643.GE28621@e103034-lin>
 <20131212173912.GF3382@arm.com>
Message-ID: <20131212180626.GQ11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:39:12PM +0000, Catalin Marinas wrote:

> If we can't really guarantee the effect of this patch, I would rather
> keep it in the LSK kernel only until the scheduler is fixed (can this be
> treated as a performance issue independent of the power-aware
> scheduling? We could get it merged quicker).

My understanding is that the behaviour is reasonably well understood,
it's just not great in all situations (hence all the energy aware
scheduler work) but then the default scheduler behaviour isn't that good
either and possibly worse (hence all the energy aware scheduler work).

I think if we're that worried about problems that might be caused by
doing this we should remove the equivalent ARMv7 code to keep the two in
parity in terms of behaviour - it's going to be enough work getting
big.LITTLE working well without introducing software only differences
between ARMv7 and ARMv8 big.LITTLE.  If you're dead set on that then I
can do patches for that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/dc55693b/attachment-0001.sig>

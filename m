From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Nov 2011 17:58:48 +0000
Subject: [PATCH RFC] ARM: unwind: optimize to not convert each table
 value but the address
In-Reply-To: <1321830763-7227-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20111120225207.GB30612@pengutronix.de>
 <1321830763-7227-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111130175847.GB6005@mbp-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2011 at 11:12:42PM +0000, Uwe Kleine-K?nig wrote:
> The offsets in the unwind index section are signed 31 bit numbers and
> the structs are sorted by this offset. So it first has offsets between
> 0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
> between 0x00000000 and 0x3fffffff. When seperating these two blocks the
> numbers are sorted even when interpreting the offsets as unsigned longs.
> 
> So instead of converting each offset hit during bisection to an absolute
> address, first determine which of the blocks needs to be searched and
> then adapt the key to find for the offset while bisecting using a simple
> unsigned long comparison.
> 
> In my tests this is faster than the original implementation modifying
> the unwind index section by 4.5%.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

The patch looks fine. Could you please post the final combined patch
(and also pipe it through checkpatch.pl as it seems to have some too
long line).

Thanks.

-- 
Catalin

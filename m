From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Tue, 9 Jun 2015 22:07:51 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <b3b09b4b8c97cbfc88fa0d5fdc5e40cd@agner.ch>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603130825.GA23991@breakpoint.cc>
 <b3b09b4b8c97cbfc88fa0d5fdc5e40cd@agner.ch>
Message-ID: <20150609200751.GC5720@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-03 17:05:16 [+0200], Stefan Agner wrote:
> As Boris guessed correctly, the reason I used the raw variant was due to
> performance improvements due to the barrier. However, I will use

yeah, do you have any numbers by chance?

> {read|write}l_relaxed instead, which should offer endian abstraction
> while not having the performance penalty due to extensive barriers...

well, even those
|$ git grep readl_relaxed arch/powerpc/
|arch/powerpc/include/asm/io.h:#define readl_relaxed(addr) readl(addr)

have the endian swap. So an abstraction like you provided earlier
would be nice :)

> --
> Stefan

Sebastian

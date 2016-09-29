From: martin@sperl.org (Martin Sperl)
Date: Thu, 29 Sep 2016 13:05:01 +0200
Subject: [PATCH v3 3/7] i2c: bcm2835: Use dev_dbg logging on transfer
 errors
In-Reply-To: <1475085056-5205-4-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-4-git-send-email-noralf@tronnes.org>
Message-ID: <BB56B9B7-75EF-4674-9951-22426C3BD8BF@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.09.2016, at 19:50, Noralf Tr?nnes <noralf@tronnes.org> wrote:
> 
> Writing to an AT24C32 generates on average 2x i2c transfer errors per
> 32-byte page write. Which amounts to a lot for a 4k write. This is due
> to the fact that the chip doesn't respond during it's internal write
> cycle when the at24 driver tries and retries the next write.
> Only a handful drivers use dev_err() on transfer error, so switch to
> dev_dbg() instead.
> 
> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
Reviewed-by: Martin Sperl <kernel@martin.sperl.org>

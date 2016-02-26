From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 26 Feb 2016 09:11:36 +0200
Subject: [PATCH, RESEND] ssb: host_soc depends on sprom
In-Reply-To: <1456433869-3919332-1-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 25 Feb 2016 21:57:43 +0100")
References: <1456433869-3919332-1-git-send-email-arnd@arndb.de>
Message-ID: <8737sgndxz.fsf@purkki.adurom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
> from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
> a build failure unless at least one of the other drivers that selects
> it is enabled:
>
> drivers/built-in.o: In function `ssb_host_soc_get_invariants':
> (.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'
>
> This adds the same select statement that is used elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")
> ---
>  drivers/ssb/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> I just noticed this hasn't shown up in linux-next yet, so I'm resending
> it to ensure it's still on someone's radar. Please ignore the resend
> if it's already in a tree that is not part of linux-next but will
> be merged eventually.
>
> See https://patchwork.linux-mips.org/patch/12091/ for the original
> submission.

Sorry, I didn't notice that linux-wireless was not CCed and I missed the
patch because it was not in my patchwork queue. But the patch is now
there and I should get to it in few days:

https://patchwork.kernel.org/patch/8426571/

-- 
Kalle Valo

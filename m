From: kvalo@codeaurora.org (Kalle Valo)
Date: Tue, 26 May 2015 10:54:10 +0000 (UTC)
Subject: brcmfmac: avoid gcc-5.1 warning
In-Reply-To: <2201884.BixNBcLJhn@wuerfel>
Message-ID: <20150526105410.13F6F1416C2@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> gcc-5.0 gained a new warning in the fwsignal portion of the brcmfmac
> driver:
> 
> drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c: In function 'brcmf_fws_txs_process':
> drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c:1478:8: warning: 'skb' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This is a false positive, and marking the brcmf_fws_hanger_poppkt function
> as 'static inline' makes the warning go away. I have checked the object
> file output and while a little code gets moved around, the size of
> the binary remains identical.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied to wireless-drivers-next.git.

Kalle Valo

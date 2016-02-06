From: kvalo@codeaurora.org (Kalle Valo)
Date: Sat,  6 Feb 2016 11:59:45 +0000 (UTC)
Subject: [v2] hostap: avoid uninitialized variable use in hfa384x_get_rid
In-Reply-To: <18181682.hKPVvnQWXk@wuerfel>
Message-ID: <20160206115945.2A872604F6@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The driver reads a value from hfa384x_from_bap(), which may fail,
> and then assigns the value to a local variable. gcc detects that
> in in the failure case, the 'rlen' variable now contains
> uninitialized data:
> 
> In file included from ../drivers/net/wireless/intersil/hostap/hostap_pci.c:220:0:
> drivers/net/wireless/intersil/hostap/hostap_hw.c: In function 'hfa384x_get_rid':
> drivers/net/wireless/intersil/hostap/hostap_hw.c:842:5: warning: 'rec' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (le16_to_cpu(rec.len) == 0) {
> 
> This restructures the function as suggested by Russell King, to
> make it more readable and get more reliable error handling, by
> handling each failure mode using a goto.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied to wireless-drivers-next.git.

Kalle Valo

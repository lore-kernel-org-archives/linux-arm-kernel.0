From: mmarek@suse.cz (Michal Marek)
Date: Mon, 8 Feb 2016 19:13:26 +0100
Subject: [PATCH] Kbuild: provide a __UNIQUE_ID for clang
In-Reply-To: <1454942318-2782493-1-git-send-email-arnd@arndb.de>
References: <1454942318-2782493-1-git-send-email-arnd@arndb.de>
Message-ID: <20160208181326.GA3784@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 03:38:32PM +0100, Arnd Bergmann wrote:
> The default __UNIQUE_ID macro in compiler.h fails to work for some drivers:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:615:1: error: redefinition of
>       '__UNIQUE_ID_firmware615'
> BRCMF_FW_NVRAM_DEF(4354, "brcmfmac4354-sdio.bin", "brcmfmac4354-sdio.txt");

I applied the patch to kbuild.git#kbuild, but can you tell me with which
commit and config you get such failure. I only see a single
MODULE_FIRMWARE() call in the expansion of BRCMF_FW_NVRAM_DEF(), which
should work with line numbers as well. And I can't reproduce it with
today's linux-next. If there is some issue with code not yet in
linux-next, it needs to be worked around, because older GCCs did not
have __COUNTER__.

Michal

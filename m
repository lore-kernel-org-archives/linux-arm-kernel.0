From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Jun 2015 14:23:30 +0200
Subject: [PATCH 2/3] ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting
In-Reply-To: <1433469518-8472-3-git-send-email-gregory.0xf0@gmail.com>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
 <1433469518-8472-3-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <2541002.3d7fzEFzRU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 June 2015 18:58:37 Gregory Fong wrote:
> From: Kevin Cernekee <cernekee@gmail.com>
> 
> If ARCH_SPARSEMEM_ENABLE=y and ARCH_{FLATMEM,DISCONTIGMEM}_ENABLE=n,
> then the logic in mm/Kconfig already makes CONFIG_SPARSEMEM the only
> choice.  This is true for all of the existing ARM users of
> ARCH_SPARSEMEM_ENABLE.
> 
> Forcing ARCH_SPARSEMEM_DEFAULT=y if ARCH_SPARSEMEM_ENABLE=y prevents
> us from ever defaulting to FLATMEM, so we should remove this setting.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

It took me a while to understand the logic, but your patch does
make a lot of sense to me now.

	Arnd

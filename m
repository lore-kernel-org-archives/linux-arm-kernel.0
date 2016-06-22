From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 22 Jun 2016 14:50:13 +0200
Subject: [PATCH] ARM: tegra: remove board_init_funcs array
In-Reply-To: <20160622124052.1263574-1-arnd@arndb.de>
References: <20160622124052.1263574-1-arnd@arndb.de>
Message-ID: <20160622125013.GH26943@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 02:39:41PM +0200, Arnd Bergmann wrote:
> In a configuration that enables CONFIG_UBSAN_SANITIZE_ALL, I am getting
> a section mismatch warning for tegra20:
> 
> WARNING: arch/arm/mach-tegra/built-in.o(.data+0x6e0): Section mismatch in reference from the variable board_init_funcs to the function .init.text:paz00_init()
> 
> The array is no longer useful here since there is only one entry,
> so we can simply call the function directly after checking
> of_machine_is_compatible(). This fixes the section mismatch
> and is easier to read.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-tegra/tegra.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

Shouldn't these section mismatches show up with default builds? I
haven't seen any when building Tegra configurations.

I'm going to apply this patch because I think it's useful, but it sure
would be nice to know why I need to enable this new UBSAN stuff to get
these warnings now.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/b557a1b5/attachment-0001.sig>

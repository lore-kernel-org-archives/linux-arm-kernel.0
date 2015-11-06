From: neilb@suse.com (Neil Brown)
Date: Fri, 06 Nov 2015 14:19:11 +1100
Subject: [PATCH] raid5-cache: add crc32c Kconfig dependency
In-Reply-To: <4308930.z8rrqMJU90@wuerfel>
References: <4308930.z8rrqMJU90@wuerfel>
Message-ID: <87si4jak7k.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04 2015, Arnd Bergmann wrote:

> The recent change of the raid5-cache code to use crc32c instead
> of crc32 causes link errors when CONFIG_LIBCRC32C is disabled:
>
> drivers/built-in.o: In function crc32c'
> core.c:(.text+0x1c6060): undefined reference to `crc32c'
>
> This adds an explicit 'select' statement like all other users
> of this function do.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5cb2fbd6ea0d ("raid5-cache: use crc32c checksum")
>
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 3e01e6fb3424..7913fdcfc849 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -123,6 +123,7 @@ config MD_RAID456
>  	tristate "RAID-4/RAID-5/RAID-6 mode"
>  	depends on BLK_DEV_MD
>  	select RAID6_PQ
> +	select LIBCRC32C
>  	select ASYNC_MEMCPY
>  	select ASYNC_XOR
>  	select ASYNC_PQ

Applied, thanks,

NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/87dc5111/attachment.sig>

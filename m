From: ospite@studenti.unina.it (Antonio Ospite)
Date: Sun, 20 Jun 2010 18:08:17 +0200
Subject: [PATCH 2/2] [ARM] pxa: make use of 'struct machine_class'
In-Reply-To: <1277042450-30382-2-git-send-email-eric.miao@canonical.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
	<1277042450-30382-2-git-send-email-eric.miao@canonical.com>
Message-ID: <20100620180817.2de11de2.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Jun 2010 22:00:50 +0800
Eric Miao <eric.miao@canonical.com> wrote:

> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> ---
>  arch/arm/mach-pxa/ezx.c      |   60 ++++-------------------------------------

The ezx part looks OK. A comment about magician below.

[...]
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index e81dd0c..6a86f22 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -764,11 +764,6 @@ static void __init magician_init(void)
>  
>  
>  MACHINE_START(MAGICIAN, "HTC Magician")
> -	.phys_io = 0x40000000,
> -	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
> -	.boot_params = 0xa0000100,
> -	.map_io = pxa_map_io,
> -	.init_irq = pxa27x_init_irq,
> -	.init_machine = magician_init,
> -	.timer = &pxa_timer,
> +	.class		= &machine_class_pxa27x,
> +	.init_machine	= magician_init,
>  MACHINE_END

Magician can use PXA27X_MACHINE() as well, can't it?

[...]

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100620/9cfddfda/attachment.sig>

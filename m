From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Jun 2013 10:23:08 +1000
Subject: [PATCH linux-next] ARM: keystone: fix compilation warning
In-Reply-To: <1372337367-6708-1-git-send-email-vincent.stehle@freescale.com>
References: <1372337367-6708-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <20130628102308.d338543da54faccf9bdfe2a5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On Thu, 27 Jun 2013 14:49:27 +0200 Vincent Stehl? <vincent.stehle@freescale.com> wrote:
>
> Fix the following compilation warning:
> 
>   arch/arm/mach-keystone/keystone.c:74:2: warning: initialization from incompatible pointer type [enabled by default]
>   arch/arm/mach-keystone/keystone.c:74:2: warning: (near initialization for ?__mach_desc_KEYSTONE.restart?) [enabled by default]
> 
> Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
> Cc: Robin Holt <holt@sgi.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: trivial at kernel.org
> ---
> 
> 
> Hi,
> 
> This warning was seen on linux-next tag next-20130627, with config ARM
> multi_v7_defconfig.

This is only needed after the merge of the akpm tree, so I will add it
there for today.

> Best regards,
> 
> V.
> 
> 
>  arch/arm/mach-keystone/keystone.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index fe4d9ff..b661c5c 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -49,7 +49,7 @@ static const char *keystone_match[] __initconst = {
>  	NULL,
>  };
>  
> -void keystone_restart(char mode, const char *cmd)
> +void keystone_restart(enum reboot_mode mode, const char *cmd)
>  {
>  	u32 val;
>  

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/904f0fef/attachment.sig>

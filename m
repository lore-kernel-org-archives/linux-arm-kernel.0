From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 20 Apr 2012 01:57:00 +0100
Subject: [PATCHv2] ARM: orion5x: Fix GPIO enable bits for MPP9
In-Reply-To: <1333858733.7150.115.camel@deadeye>
References: <1333858733.7150.115.camel@deadeye>
Message-ID: <1334883420.3209.230.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-04-08 at 05:18 +0100, Ben Hutchings wrote:
> Commit 554cdaefd1cf7bb54b209c4e68c7cec87ce442a9 ('ARM: orion5x: Refactor
> mpp code to use common orion platform mpp.') seems to have accidentally
> inverted the GPIO valid bits for MPP9 (only).  For the mv2120 platform
> which uses MPP9 as a GPIO LED device, this results in the error:
> 
> [   12.711476] leds-gpio: probe of leds-gpio failed with error -22
> 
> Reported-by: Henry von Tresckow <hvontres@gmail.com>

Tested-by: Hans Henry von Tresckow <hvontres@gmail.com>

(on the mv2120, and applied to Debian's 3.2 tree)

> References: http://bugs.debian.org/667446
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: stable at vger.kernel.org [v3.0+]
> ---
> v2: Add subject of the earlier commit
> 
> Ben.
> 
>  arch/arm/mach-orion5x/mpp.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/mpp.h b/arch/arm/mach-orion5x/mpp.h
> index eac6897..db70e79 100644
> --- a/arch/arm/mach-orion5x/mpp.h
> +++ b/arch/arm/mach-orion5x/mpp.h
> @@ -65,8 +65,8 @@
>  #define MPP8_GIGE               MPP(8,  0x1, 0, 0, 1,   1,   1)
>  
>  #define MPP9_UNUSED		MPP(9,  0x0, 0, 0, 1,   1,   1)
> -#define MPP9_GPIO		MPP(9,  0x0, 0, 0, 1,   1,   1)
> -#define MPP9_GIGE               MPP(9,  0x1, 1, 1, 1,   1,   1)
> +#define MPP9_GPIO		MPP(9,  0x0, 1, 1, 1,   1,   1)
> +#define MPP9_GIGE               MPP(9,  0x1, 0, 0, 1,   1,   1)
>  
>  #define MPP10_UNUSED		MPP(10, 0x0, 0, 0, 1,   1,   1)
>  #define MPP10_GPIO		MPP(10, 0x0, 1, 1, 1,   1,   1)

-- 
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/945f26f1/attachment.sig>

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Feb 2016 23:24:34 +0000
Subject: [PATCH] ARM: boot: Add an implementation of strnlen for libfdt
In-Reply-To: <1455231994-12048-1-git-send-email-robh@kernel.org>
References: <1455231994-12048-1-git-send-email-robh@kernel.org>
Message-ID: <20160211232434.GZ10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 05:06:34PM -0600, Rob Herring wrote:
> Recent versions of libfdt add a dependency on strnlen. Copy the
> implementation in lib/string.c here, so we can update libfdt.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
> Russell,
> 
> I have a pending libfdt update, so I'd like to take this thru the DT 
> tree with your ack.
> 
> Rob
> 
>  arch/arm/boot/compressed/string.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
> index 36e53ef..6894674 100644
> --- a/arch/arm/boot/compressed/string.c
> +++ b/arch/arm/boot/compressed/string.c
> @@ -65,6 +65,15 @@ size_t strlen(const char *s)
>  	return sc - s;
>  }
>  
> +size_t strnlen(const char *s, size_t count)
> +{
> +	const char *sc;
> +
> +	for (sc = s; count-- && *sc != '\0'; ++sc)
> +		/* nothing */;
> +	return sc - s;
> +}
> +
>  int memcmp(const void *cs, const void *ct, size_t count)
>  {
>  	const unsigned char *su1 = cs, *su2 = ct, *end = su1 + count;
> -- 
> 2.5.0
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

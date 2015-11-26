From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 00:08:40 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151126000840.GV8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 01:51:04PM -0800, Stephen Boyd wrote:
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 85e374f873ac..48c77d422a0d 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -250,8 +250,14 @@ static inline int cpu_is_pj4(void)
>  
>  	return 0;
>  }
> +
> +static inline bool __attribute_const__ cpu_is_pj4_nomp(void)
> +{
> +	return read_cpuid_part() == 0x56005810;

One other thing here, we really ought to avoid adding more magic numbers
to this file.  We have the ARM processors nicely #defined, but not a lot
else.  Maybe its time that we continued with the nice definitions for
these part numbers?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

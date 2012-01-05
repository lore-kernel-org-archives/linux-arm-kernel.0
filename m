From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 05 Jan 2012 14:47:07 +0200
Subject: [PATCH v4] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <1325766081-27864-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1325766081-27864-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <4F059BCB.9050504@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry guys, this patch raises compiler errors.

On 01/05/2012 02:21 PM, Lauri Hintsala wrote:
> diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
> index bde5f66..7e72a6c 100644
> --- a/arch/arm/mach-mxs/include/mach/mxs.h
> +++ b/arch/arm/mach-mxs/include/mach/mxs.h
> @@ -33,6 +33,7 @@
>   		machine_is_stmp378x() ||				\
>   		0)
>   #define cpu_is_mx28()		(					\
> +		machine_is_apx4devkit() ||				\
>   		machine_is_mx28evk() ||					\
>   		machine_is_m28evk() ||					\
>   		machine_is_tx28() ||					\

machine_is_apx4devkit is undefiend.


> diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
> index 6777674..3e5309d 100644
> --- a/arch/arm/mach-mxs/include/mach/uncompress.h
> +++ b/arch/arm/mach-mxs/include/mach/uncompress.h
> @@ -62,6 +62,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>   	case MACH_TYPE_MX23EVK:
>   		mxs_duart_base = MX23_DUART_BASE_ADDR;
>   		break;
> +	case MACH_TYPE_APX4DEVKIT:
>   	case MACH_TYPE_MX28EVK:
>   	case MACH_TYPE_M28EVK:
>   	case MACH_TYPE_TX28:

Also MACH_TYPE_APX4DEVKIT is undefiend.


Shawn: Should we temporary add following lines into headers? Any better 
suggestions?

#ifndef machine_is_apx4devkit
#define machine_is_apx4devkit() 0
#endif

#ifndef MACH_TYPE_APX4DEVKIT
#define MACH_TYPE_APX4DEVKIT 0
#endif

BR,
Lauri

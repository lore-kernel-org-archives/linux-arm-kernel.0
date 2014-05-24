From: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 24 May 2014 11:56:28 -0700
Subject: [PATCH 21/24] ARM64:ILP32: The native siginfo is used instead
 of the compat siginfo.
In-Reply-To: <1400914939-9708-22-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-22-git-send-email-apinski@cavium.com>
Message-ID: <5380EB5C.7060903@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2014 12:02 AM, Andrew Pinski wrote:
>  
> +/* ILP32 uses the native siginfo and not the compat struct */
> +#define COMPAT_USE_NATIVE_SIGINFO	!is_a32_compat_task()
> +

<nitpick> Probably want parens around that expression? </nitpick>

	-hpa

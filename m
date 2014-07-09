From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 09 Jul 2014 13:38:25 -0700
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <53BDA841.4000400@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 04:29 AM, Andrey Ryabinin wrote:
> +config KASAN
> +	bool "AddressSanitizer: dynamic memory error detector"
> +	default n
> +	help
> +	  Enables AddressSanitizer - dynamic memory error detector,
> +	  that finds out-of-bounds and use-after-free bugs.

This definitely needs some more text like "This option eats boatloads of
memory and will slow your system down enough that it should never be
used in production unless you are crazy".

From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 11 Jul 2014 17:59:34 -0700
Subject: [RFC/PATCH -next 00/21] Address sanitizer for kernel (kasan)
 - dynamic memory error detector.
In-Reply-To: <1404903678-8257-1-git-send-email-a.ryabinin@samsung.com>
References: <1404903678-8257-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <53C08876.10209@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 04:00 AM, Andrey Ryabinin wrote:
> 
> Address sanitizer dedicates 1/8 of the low memory to the shadow memory and uses direct
> mapping with a scale and offset to translate a memory address to its corresponding
> shadow address.
> 
> Here is function to translate address to corresponding shadow address:
> 
>      unsigned long kasan_mem_to_shadow(unsigned long addr)
>      {
> 		return ((addr) >> KASAN_SHADOW_SCALE_SHIFT)
>        	             + kasan_shadow_start - (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT);
>      }
> 
> where KASAN_SHADOW_SCALE_SHIFT = 3.
> 

How does that work when memory is sparsely populated?

	-hpa

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 May 2010 15:55:12 +0100
Subject: [PATCH 1/1] silence a bogus sparse warning in unwind.c
In-Reply-To: <1273586774-9604-1-git-send-email-virtuoso@slind.org>
References: <1273586774-9604-1-git-send-email-virtuoso@slind.org>
Message-ID: <20100511145512.GA32186@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 05:06:14PM +0300, Alexander Shishkin wrote:
> The check for compiler which is supposed to miscompile unwind tables
> clearly has nothing to do with sparse (which does not define necessary
> macros anyway), so simply silence it.
> 
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> ---
>  arch/arm/kernel/unwind.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 50292cd..dd81a91 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -26,6 +26,7 @@
>   * http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
>   */
>  
> +#ifndef __CHECKER__
>  #if !defined (__ARM_EABI__)

#if !defined(__ARM_EABI__) && !defined(__CHECKER__) ?

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Oct 2015 17:49:24 +0100
Subject: [PATCH 7/7] Document the use of the arm64 contpte/nonconpte flags.
In-Reply-To: <1443818865-19846-8-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
 <1443818865-19846-8-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151005164924.GB5557@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 03:47:45PM -0500, Jeremy Linton wrote:
> These flags allow the user to enable/disable the contiguous PTE
> detection and marking on the kernel command line for
> debugging purposes.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  Documentation/kernel-parameters.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 22a4b68..2766290 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -744,6 +744,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			seconds. Defaults to 10*60 = 10mins. A value of 0
>  			disables the blank timer.
>  
> +	contpte		[ARM64] Enable contiguous PTE marking for the kernel
> +			linear range. This may be disabled with nocontpte.
> +			Default: Enabled

I recall you asked the question but I didn't have the time to reply. I
don't think we need a command line option for this. In the "unlikely"
event that something is broken in hardware (or software) and we want to
disable the contiguous bit, I would rather have a Kconfig option.

-- 
Catalin

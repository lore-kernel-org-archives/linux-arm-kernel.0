From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Oct 2011 11:13:02 -0500
Subject: [PATCH 2/3] ARM: Exynos4: Add ioremap interceptor for statically
	remapped regions
In-Reply-To: <1318234289-22041-3-git-send-email-thomas.abraham@linaro.org>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
	<1318234289-22041-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4E95BC8E.8010105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2011 03:11 AM, Thomas Abraham wrote:
> ioremap() request for statically remapped regions are intercepted and the
> statically assigned virtual address is returned. For requests for which
> there are no statically remapped regions, the requests are let through.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos4/cpu.c             |   16 ++++++++++++++++
>  arch/arm/mach-exynos4/include/mach/io.h |    4 ++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 

You won't need this with Nico's vmalloc.h clean-up series. It does
exactly this but generically for all platforms.

Rob

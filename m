From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Jun 2010 08:52:45 +0200
Subject: [PATCH 2/2] pxa/spitz: Rework spitz
In-Reply-To: <1276238740-10640-2-git-send-email-marek.vasut@gmail.com>
References: <1276238740-10640-1-git-send-email-marek.vasut@gmail.com>
	<1276238740-10640-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <201006110852.45838.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 11. ?ervna 2010 08:45:40 Marek Vasut napsal(a):
> This huge patch mostly shuffles code. The spitz.c file contained terrible
> mess and needed a cleanup, here it is:
> 
> 1) Made every part modular, components are not built in if not selected.
> 2) Removed loads of preprocessor goo, mostly "#ifdef MACH_AKITA ....
> #endif" and similar code. The kernel size will grow by a few kb now, but
> the file is much more readable.
> 3) Reworked SD/CF power setting function and made it reentrant.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/include/mach/spitz.h |    2 -
>  arch/arm/mach-pxa/spitz.c              |  748
> ++++++++++++++++++-------------- 2 files changed, 420 insertions(+), 330
> deletions(-)
> 

Pavel, Eric, I tested this on metan's Z, could you give it a go ?
Thanks!

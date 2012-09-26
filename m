From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Sep 2012 15:05:24 -0700
Subject: [PATCH 08/11] ARM: Move some macros from entry-armv to
 entry-header
In-Reply-To: <1348522080-32629-8-git-send-email-anton.vorontsov@linaro.org>
References: <20120924212648.GA27605@lizard>
 <1348522080-32629-8-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <50637C24.90206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/12 14:27, Anton Vorontsov wrote:
> Just move the macros into header file as we would want to use them for
> KGDB FIQ entry code.
>
> The following macros were moved:
>
>  - svc_entry
>  - usr_entry
>  - kuser_cmpxchg_check
>  - vector_stub
>
> To make kuser_cmpxchg_check actually work across different files, we
> also have to make kuser_cmpxchg64_fixup global.
>
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Why can't we put the fiq entry code from the next patch into
entry-armv.S? Sorry if this has been asked before but I don't see any
reasoning in the commit text.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

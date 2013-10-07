From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 07 Oct 2013 17:57:58 +0200
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for
 BE correct operation
In-Reply-To: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <5252DA06.8000303@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 17:48, Victor Kamensky wrote:
> Hi Will, Ben, Russell, Thomas,
>
> Please review second version of patch that fixes TLB asid issue in big endian
> V7 image.
>
> Changes from v1:
>     Note previous patch subject line was 'ARM: tlb:
>     __flush_tlb_mm need to use int asid var for BE correct operation'
>
>     Added 'unsigned int' cast into ASID macro itself rather
>     then use intermediate 'int' variable in __flush_tlb_mm function.
>     This is done per v1 patch discussion at
>
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202583.html
>
> Tested with Linaro BE topic branch on Arndale board. Both LE and BE
> images were tested.

If you are booting on the Arndale board, is there a patch to mark
the relevant Exynos devices as BE capable?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

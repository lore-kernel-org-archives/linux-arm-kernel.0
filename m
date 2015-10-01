From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 1 Oct 2015 19:42:43 +0530
Subject: [PATCH] thermal: exynos: fix register read in TMU
In-Reply-To: <CAJKOXPfyC8etcPe373q6Pc1qWb2zVnHE96V+Rh5mPmpzAxFjiA@mail.gmail.com>
References: <1443699599-9693-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAJKOXPfyC8etcPe373q6Pc1qWb2zVnHE96V+Rh5mPmpzAxFjiA@mail.gmail.com>
Message-ID: <20151001141243.GA5061@sudip-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 10:18:57PM +0900, Krzysztof Kozlowski wrote:
> 2015-10-01 20:39 GMT+09:00 Sudip Mukherjee <sudipm.mukherjee@gmail.com>:
> > The value of emul_con was getting overwritten if the selected soc is
> > SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
> > register in the case of SOC_ARCH_EXYNOS5260.
> 
> How the value is overwritten if the soc is Exynos5260? I can't see it
> (although the "else if" is still more obvious than "if" but how does
> the description match the code?).
The code here is:
if (data->soc == SOC_ARCH_EXYNOS5260)
	emul_con = EXYNOS5260_EMUL_CON;
if (data->soc == SOC_ARCH_EXYNOS5433)
	emul_con = EXYNOS5433_TMU_EMUL_CON;
else if (data->soc == SOC_ARCH_EXYNOS7)
	emul_con = EXYNOS7_TMU_REG_EMUL_CON;
else
	emul_con = EXYNOS_EMUL_CON;

So if data->soc is SOC_ARCH_EXYNOS5260 , then emul_con becomes
EXYNOS5260_EMUL_CON. But again for the else part it will become
EXYNOS_EMUL_CON.

regards
sudip

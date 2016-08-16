From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 16 Aug 2016 15:42:38 +0900
Subject: [PATCH 4/7] pinctrl: samsung: Add GPFx support of Exynos5433
In-Reply-To: <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <CA+Ln22ESSK2tK=jiRU94H=sFz23Eoh0Z96k3rBoaz9xnZS9iJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-08-16 15:27 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> From: Joonyoung Shim <jy0922.shim@samsung.com>
>
> This patch add the support of GPFx pin of Exynos5433 SoC. Exynos5433 has
> different memory map of GPFx from previous Exynos SoC. Exynos GPIO has
> following register to control gpio funciton. Usually, all registers of GPIO
> are included in same domain.
> - CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND
>
> But, GPFx are included in two domain as following. So, this patch supports
> the GPFx pin which handle the on separate two domains.
> - ALIVE domain : CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - IMEM domain  : EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND

I'm afraid I don't get anything from the description above. Could you
describe the layout of registers in memory map and IRQ routing of the
pins?

Best regards,
Tomasz

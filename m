From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 7 May 2012 14:50:14 -0700
Subject: [PATCH] ARM: BCMRING: Fix UART declaration and clk dev name
 mismatch
In-Reply-To: <CAP=VYLofEt_+CZmv2H90CTJ2F5gDfu5o8qfJN-a2bALC5LN=Xg@mail.gmail.com>
References: <4FA823C4.1070109@broadcom.com>
 <CAP=VYLofEt_+CZmv2H90CTJ2F5gDfu5o8qfJN-a2bALC5LN=Xg@mail.gmail.com>
Message-ID: <4FA84396.7090808@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/7/2012 2:39 PM, Paul Gortmaker wrote:
>
> Do things work if you simply do a partial revert of 888073d41 ?
>
> Meaning:
>
> -static AMBA_APB_DEVICE(uartA, "uartA", 0, MM_ADDR_IO_UARTA, {IRQ_UARTA}, NULL);
> -static AMBA_APB_DEVICE(uartB, "uartB", 0, MM_ADDR_IO_UARTB, {IRQ_UARTB}, NULL);
> +static AMBA_APB_DEVICE(uartA, "uarta", 0, MM_ADDR_IO_UARTA, {IRQ_UARTA}, NULL);
> +static AMBA_APB_DEVICE(uartB, "uartb", 0, MM_ADDR_IO_UARTB, {IRQ_UARTB}, NULL);
>
> The original error messages led me to believe it was two errors;
> i.e. (1) the wrong # of args error, and (2) the "a" vs. "A" error.  But
> I think Olof was right on his 1st instinct, that it was just the
> single error, and the a<--->  A thing was a side effect.
>
> In which case the above should just work, and it will also keep
> the naming consistent with what it was before any of these
> commits.
Yes.  Either way works. Just in original code, the name uartA and the 
name string "uarta" looks confusing and easy to get it wrong.

Thanks,
JD
>
> Paul.
> --
>

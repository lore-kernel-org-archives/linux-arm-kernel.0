From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Mar 2018 19:23:11 -0300
Subject: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
In-Reply-To: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
References: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Tue, Mar 6, 2018 at 7:02 PM, Martin Kaiser <martin@kaiser.cx> wrote:
> The ssi1_ipg clock depends on ssi1_ipg_per. Set ssi1_ipg_per as parent
> clock of ssi1_ipg. Without this link, the fsl_ssi driver does not
> activate the ssi1_ipg clock correctly and ssi1 is unable to transfer
> audio data.
>
> Fix the parent clock of ssi2 as well, it shows the same behaviour.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Dear all,
>
> could you have a look at this patch? This makes SSI1 and 2 work for me.

I get audio working from SSI1, but I guess this is due to the fact
that the bootloader enables the SSI clock:

I have the following in U-Boot:

/* Enable the clocks */
DATA 4 0x53f8000c 0x1fffffff
DATA 4 0x53f80010 0xffffffff
DATA 4 0x53f80014 0xfdfff

I will try tomorrow to disable the SSI1 clock from U-Boot and apply your patch.

Will let you know how my testing goes.

> With the default "ipg" parent clocks, I get no ipg clocks on the SSIs.
> However, I was wondering why we don't need anything similar e.g. for the
> UARTs...

Maybe your bootloader is already turning on the UART clocks?

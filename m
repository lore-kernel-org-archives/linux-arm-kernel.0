From: dianders@chromium.org (Doug Anderson)
Date: Tue, 15 Jul 2014 09:19:38 -0700
Subject: [PATCH v3 2/2] ARM: dts: Add mask-tpm-reset DT node to the
 exynos5800-peach-pi
In-Reply-To: <1405420294-9323-3-git-send-email-vikas.sajjan@samsung.com>
References: <1405420294-9323-1-git-send-email-vikas.sajjan@samsung.com>
 <1405420294-9323-3-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAD=FV=VtrMTbaaN9MA+8=rM23UY9efktsOHab51H=Nm7JVJz4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas,

On Tue, Jul 15, 2014 at 3:31 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
> being reset across sleep/wake.  If we don't set it to anything then
> the TPM will be reset.  U-Boot will detect this as invalid
> and will reset the system on resume time. This GPIO can always be low
> and not hurt anything.  It will get pulled back high again during a
> normal warm reset when it will default back to an input.
>
> To properly preserve the TPM state across suspend/resume and to make
> the chrome U-Boot happy, properly set the GPIO to mask the
> reset to the TPM.
>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>

-Doug

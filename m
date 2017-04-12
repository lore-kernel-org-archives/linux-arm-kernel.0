From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Apr 2017 17:09:08 +0100
Subject: [PATCH 3/8] arm64: defconfig: enable TCG_TPM and TCG_CRB
In-Reply-To: <1492012980-11650-4-git-send-email-timur@codeaurora.org>
References: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
 <1492012980-11650-4-git-send-email-timur@codeaurora.org>
Message-ID: <20170412160907.GA7153@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 11:02:55AM -0500, Timur Tabi wrote:
> Some ARM64 server systems have a Trusted Platform Module security chip
> on the board, and the chip is used to validate the operating system,
> among other things.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a684c92..99e9964 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -240,6 +240,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
>  CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
>  CONFIG_SERIAL_MVEBU_UART=y
>  CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_TCG_TPM=y
> +CONFIG_TCG_CRB=y

I see there are patches queued in linux-next enabling some arm64 TPM CRB
support, which I believe are related.

As I have commented elsewhere [1], I think those have been taken
prematurely, and I'm not sure it's a good idea to enable this just yet,
due to that. There are spec issues to be addressed in the draft that is
still open.

[1] https://lkml.kernel.org/r/20170411113652.GB32267 at leverpostej

Thanks,
Mark.

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Jun 2014 14:56:50 +0400
Subject: [PATCH v1 3/3] arm64: Fix the APM X-Gene SoC SATA PHY clock DTS
 node csr-mask of the SATA Host Controller 1.
In-Reply-To: <1403518538-30697-4-git-send-email-stripathi@apm.com>
References: <1403518538-30697-1-git-send-email-stripathi@apm.com>
 <1403518538-30697-4-git-send-email-stripathi@apm.com>
Message-ID: <53A807F2.4000408@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/23/2014 02:15 PM, Suman Tripathi wrote:

> This patch fixes the SATA PHY clock DTS node csr-mask of the SATA
> Host controller 1. This patch also fixes the status of the PHY
> clock node of SATA Host controller 1.

> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   arch/arm64/boot/dts/apm-storm.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index f8c40a6..d14bcc4 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -184,9 +184,9 @@
>   				reg = <0x0 0x1f21c000 0x0 0x1000>;
>   				reg-names = "csr-reg";
>   				clock-output-names = "sataphy1clk";
> -				status = "disabled";
> +				status = "ok";

    You don't need the specifically set "status to "ok" unless you're 
overriding the "status" prop; "ok" is assumed AFAIK.

WBR, Sergei

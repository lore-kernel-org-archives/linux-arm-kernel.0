From: robherring2@gmail.com (Rob Herring)
Date: Tue, 5 May 2015 14:41:21 -0500
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <1430817426-5241-2-git-send-email-stripathi@apm.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <1430817426-5241-2-git-send-email-stripathi@apm.com>
Message-ID: <CAL_JsqK0pCtL2pbG7RttYd7BDxQHxdECHN_9X9MpLTuVEOxzsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 4:17 AM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds the arasan sdhc nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)

[...]

> @@ -533,6 +567,16 @@
>                         interrupts = <0x0 0x4f 0x4>;
>                 };
>
> +               sdhc0: sdhc at 1c000000 {
> +                       device_type = "sdhc";

device_type generally should not be used (there are a few exceptions).

> +                       compatible = "arasan,sdhci-4.9a";

If you ever have an integration or xgene specific problem, you need a
chip specific compatible.

Rob

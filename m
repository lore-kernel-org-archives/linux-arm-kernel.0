From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Aug 2014 08:00:37 -0500
Subject: [PATCH v5 2/4] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <1408778588-3215-3-git-send-email-lho@apm.com>
References: <1408778588-3215-1-git-send-email-lho@apm.com>
 <1408778588-3215-2-git-send-email-lho@apm.com>
 <1408778588-3215-3-git-send-email-lho@apm.com>
Message-ID: <CAL_JsqKHV=yY9K3e4cQ4+vSvvVwM56hBuEc5OFXHqAmQZkp3Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 2:23 AM, Loc Ho <lho@apm.com> wrote:
> This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |   83 ++++++++++++++++++++
>  1 files changed, 83 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>
> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> new file mode 100644
> index 0000000..ce8c30e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> @@ -0,0 +1,83 @@
> +* APM X-Gene SoC EDAC nodes
> +
> +EDAC nodes are defined to describe on-chip error detection and correction.
> +There are four types of EDAC:

EDAC is somewhat a Linux term which makes me suspicious. Is this
really how the h/w is defined (i.e. I would find "EDAC" blocks in the
h/w reference manual?)?

> +
> +  memory controller    - Memory controller
> +  PMD (L1/L2)          - Processor module unit (PMD) L1/L2 cache
> +  L3                   - CPU L3 cache
> +  SoC                  - SoC IP such as SATA, Ethernet, and etc
> +
> +The following section describes the memory controller DT node binding.
> +
> +Required properties:
> +- compatible           : Shall be "apm,xgene-edac-mc".

This is only EDAC registers or the entire memory controller? If they
are truly separate and only for EDAC, then it is fine. Otherwise, you
should define the actual h/w block in DT and if a block needs to hook
up to multiple drivers, then that is a Linux problem in which you
should use drivers/mfd or drivers/soc.

Similar question for the rest.

Rob

From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 May 2016 11:47:04 +0100
Subject: [PATCH v2 1/3] regulator: DT: Add DT property for operation mode
 configuration
In-Reply-To: <1463987611-32139-2-git-send-email-henryc.chen@mediatek.com>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
 <1463987611-32139-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160523104703.GB26992@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 03:13:29PM +0800, Henry Chen wrote:
> Some regulators support their operating mode to be changed by consumers for
> module specific purpose. Add a DT property to support this.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt |  5 +++++
>  include/dt-bindings/regulator/regulator.h                 | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/regulator/regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index ecfc593..e505d0b 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -49,6 +49,11 @@ Optional properties:
>  	0: Disable active discharge.
>  	1: Enable active discharge.
>  	Absence of this property will leave configuration to default.
> +- regulator-supported-modes: Regulators can run in a variety of different
> +  operating modes depending on output load. This allows further system power
> +  savings by selecting the best (and most efficient) regulator mode for a
> +  desired load. The definition for each of these operation is defined at
> +  include/dt-bindings/regulator/regulator.h

This doesen't tell me for the property is formatted.

Is it a list? A mask?

>  
>  Deprecated properties:
>  - regulator-compatible: If a regulator chip contains multiple
> diff --git a/include/dt-bindings/regulator/regulator.h b/include/dt-bindings/regulator/regulator.h
> new file mode 100644
> index 0000000..2ed1dfd
> --- /dev/null
> +++ b/include/dt-bindings/regulator/regulator.h
> @@ -0,0 +1,14 @@
> +/*
> + * This header provides constants for binding regulator.
> + */
> +
> +#ifndef _DT_BINDINGS_REGULATOR_REGULATOR_H
> +#define _DT_BINDINGS_REGULATOR_REGULATOR_H
> +
> +/* Regulator operating modes */
> +#define REGULATOR_OPERATION_MODE_FAST			0x0
> +#define REGULATOR_OPERATION_MODE_NORMAL			0x1
> +#define REGULATOR_OPERATION_MODE_IDLE			0x2
> +#define REGULATOR_OPERATION_MODE_STANDBY		0x3

These sound like they're tied to linux internal details (e.g. the
implementation of idle and/or suspend).

What do each of these actually mean?

Mark.

> +
> +#endif
> -- 
> 1.8.1.1.dirty
> 

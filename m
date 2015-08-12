From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 13 Aug 2015 01:10:29 +0200
Subject: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x)
 support
In-Reply-To: <55CBCDED.8010409@tul.cz>
References: <55CBCDED.8010409@tul.cz>
Message-ID: <55CBD265.7080705@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 13.8.2015 v 00:51 Petr Cvek napsal(a):

> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
> index e88d4f6..3df3f0a 100644
> --- a/drivers/mfd/htc-pasic3.c
> +++ b/drivers/mfd/htc-pasic3.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
>   *
> + * LED support:
> + * Copyright (C) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; version 2 of the License.
> @@ -65,8 +68,76 @@ EXPORT_SYMBOL(pasic3_read_register); /* for leds-pasic3 */
>   * LEDs
>   */

Just some P.S.

Checkpatch warns me about spaces around * in this section. It seems it thinks it is some pointer. Is this behavior OK (I assume it cannot find begining of comment or am I doing something bad?).

Checkpatch also throws warning about new file and MAINTAINERS list updating (for leds-pasic3.c). I assume it falls into LEDs subsystem.

As the patch changes the definitions for many subsystems, are there another people who should be awared of this patch?

Cheers,
Petr Cvek

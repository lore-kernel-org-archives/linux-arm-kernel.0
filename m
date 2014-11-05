From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Wed, 05 Nov 2014 06:56:44 +0100
Subject: [PATCH 0/7] Pinctrl support for Zynq
In-Reply-To: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5459BC1C.3000807@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> Soren Brinkmann (7):
>   pinctrl: pinconf-generic: Declare dt_params/conf_items const
>   pinctrl: pinconf-generic: Infer map type from DT property
>   pinctrl: pinconf-generic: Allow driver to specify DT params
>   pinctrl: zynq: Document DT binding
>   pinctrl: Add driver for Zynq
>   ARM: zynq: Enable pinctrl
>   ARM: zynq: DT: Add pinctrl information

Thanks for your work on this,

Tested-by: Andreas F?rber <afaerber@suse.de>

I've tracked down all 54 MIO pins of the Parallella and cooked up the
equivalent DT patch. QSPI and USB still seem to be missing drivers
upstream; I reused the SPI driver for the QSPI with pinctrl and
Punnaiah's chipidea driver (not fully working) without pinctrl for lack
of group/function definitions. For testing purposes I've configured a
heartbeat trigger for the USER_LED (CR10).

To my disappointment these pinctrl additions did not fix one issue:
Whenever a write access to be handled by the bitstream (0x808f0f04) is
performed, the board hangs and the heartbeat stops. Would a bug in the
bitstream allow this to happen, or are more drivers missing to actually
make use of the PL in general? With a downstream ADI/Xilinx 3.12 kernel
that problem does not surface.

Regards,
Andreas

https://github.com/afaerber/linux/commits/parallella-next

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/1189e856/attachment.sig>

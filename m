From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 1 Oct 2018 12:29:53 +0200
Subject: [PATCH v3 0/3] Add Amlogic video decoder driver
In-Reply-To: <20180928142816.4311-1-mjourdan@baylibre.com>
References: <20180928142816.4311-1-mjourdan@baylibre.com>
Message-ID: <cfb89cf9-4fce-7fab-48e1-a0311b80d993@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2018 04:28 PM, Maxime Jourdan wrote:
> Hi everyone,
> 
> This patch series adds support for the Amlogic video decoder,
> as well as the corresponding dt bindings for GXBB/GXL/GXM chips.
> 
> It features decoding for the following formats:
> - MPEG 1
> - MPEG 2
> 
> The following formats will be added in future patches:
> - MJPEG
> - MPEG 4 (incl. Xvid, H.263)
> - H.264
> - HEVC (incl. 10-bit)
> 
> The following formats' development has still not started, but they are
> supported by the hardware:
> - VC1
> - VP9
> 
> The code was made in such a way to allow easy inclusion of those formats
> in the future.
> 
> The decoder is single instance.
> 
> Files:
>  - vdec.c handles the V4L2 M2M logic
>  - esparser.c manages the hardware bitstream parser
>  - vdec_helpers.c provides helpers to DONE the dst buffers as well as
>  various common code used by the codecs
>  - vdec_1.c manages the VDEC_1 block of the vdec IP
>  - codec_mpeg12.c enables decoding for MPEG 1/2.
>  - vdec_platform.c links codec units with vdec units
>  (e.g vdec_1 with codec_mpeg12) and lists all the available
>  src/dst formats and requirements (max width/height, etc.),
>  per compatible chip.
> 
> Firmwares are necessary to run the vdec. They can currently be found at:
> https://github.com/chewitt/meson-firmware

Are you trying to get this into the linux-firmware repository?

I believe that Mauro requires that before he will merge this driver.

So I think this driver will be ready to be merged once v4 is posted,
dt-bindings is Acked and the firmware is merged to the linux-firmware repo.

Regards,

	Hans

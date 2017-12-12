From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 12 Dec 2017 12:29:41 +0800
Subject: [PATCH] ASoC: sun4i-codec: fix to enable 12Khz and 24Khz audio
 playback and capture sample rates
In-Reply-To: <20171211172426.GA23199@andrea-laptop>
References: <20171211172426.GA23199@andrea-laptop>
Message-ID: <CAGb2v65pZEcUHSbvHiNXrop3aGEEiLdeBi3__hjo8hwBQVXMSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 1:24 AM, Andrea Bondavalli
<andrea.bondavalli74@gmail.com> wrote:
> H3 ASoC supports 12Khz and 24Khz audio sample rates but the current drivers doesn't
> advertise these rates properly and they cannot be used.
> For example attempt to capture at 12Khz uses 11Khz (same applies to audio playback):
>
> Recording raw data '/tmp/test' : Signed 16 bit Little Endian, Rate 12000 Hz, Stereo
> Warning: rate is not accurate (requested = 12000Hz, got = 11025Hz)
>
> This patch fixes the audio sample rates declared and supported by the driver
> according to the H3 data sheet.
> Specifically for audio playback:
> 8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 96000, 192000
> and for audio capture:
> 8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000
>
> Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

However, please also send this to the alsa-devel mailing list.

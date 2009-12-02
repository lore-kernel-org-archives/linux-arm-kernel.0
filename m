From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 2 Dec 2009 09:22:23 +0900
Subject: [PATCH 1/7] S3C64XX: Staticise platform data for PCM devices
In-Reply-To: <1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1b68c6790912011622g6eb8f5e6kd1c27b59053255b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 1:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The symbols aren't declared and don't need to be exported, they go
> along with the device structure.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> ?arch/arm/plat-s3c64xx/dev-audio.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
> index 9e07344..a21a88f 100644
> --- a/arch/arm/plat-s3c64xx/dev-audio.c
> +++ b/arch/arm/plat-s3c64xx/dev-audio.c
> @@ -118,7 +118,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
> ? ? ? ?},
> ?};
>
> -struct s3c_audio_pdata s3c_pcm0_pdata = {
> +static struct s3c_audio_pdata s3c_pcm0_pdata = {
> ? ? ? ?.cfg_gpio = s3c64xx_pcm_cfg_gpio,
> ?};
>
> @@ -151,7 +151,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
> ? ? ? ?},
> ?};
>
> -struct s3c_audio_pdata s3c_pcm1_pdata = {
> +static struct s3c_audio_pdata s3c_pcm1_pdata = {
> ? ? ? ?.cfg_gpio = s3c64xx_pcm_cfg_gpio,
> ?};
>
> --
> 1.6.5.3

Acked-By: Jassi Brar <jassi.brar@samsung.com>

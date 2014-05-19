From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 19 May 2014 07:39:47 +0200
Subject: [PATCH] Fix for possible null pointer dereference in dma.c
In-Reply-To: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20140519073947.66bb2c46@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rickard Strandqvist wrote:
> There is otherwise a risk of a possible null pointer dereference.
> 
> Was largely found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  sound/soc/samsung/dma.c |   10 ++++++----
>  1 fil ?ndrad, 6 till?gg(+), 4 borttagningar(-)
> 
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index dc09b71..b1f6757 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -115,17 +115,19 @@ static void dma_enqueue(struct snd_pcm_substream *substream)
>  static void audio_buffdone(void *data)
>  {
>  	struct snd_pcm_substream *substream = data;
> -	struct runtime_data *prtd = substream->runtime->private_data;
> +	struct runtime_data *prtd = NULL;
>  
>  	pr_debug("Entered %s\n", __func__);
>  
> -	if (prtd->state & ST_RUNNING) {
> +	if(substream)
>
Missing space.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 18:48:29 +0000
Subject: [PATCH 08/10] ASoC: ux500_pcm: Differentiate between pdata and
 DT initialisation
In-Reply-To: <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20131119184829.GF2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:07:47AM +0000, Lee Jones wrote:

> require slightly different flags to inform the core that we 'are'
> booting with DT.

Is there some situation when we would want to say we're booting from DT
when we aren't?  Just wondering about the quotes.

> +static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
> +	.pcm_hardware = &ux500_pcm_hw,
> +	.prealloc_buffer_size = 128 * 1024,

You shouldn't need to set this explicitly, the generic code should be
able to pick a number for you - if you do need this number please
explain why the number was chosen in the comments (or fix the core to
guess better).  At the minute the core just makes up a number too but at
least then it's a consistent random number between platforms.

Can you also get away without the pcm_hardware - the core should also
have support for discovering this by querying the DMA controller?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/18068609/attachment.sig>

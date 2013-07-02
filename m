From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 02 Jul 2013 17:25:46 +0200
Subject: [alsa-devel] [PATCH 1/2] ASoC: atmel_ssc_dai: move set dma data
 to startup callback
In-Reply-To: <1372755849-19546-2-git-send-email-voice.shen@atmel.com>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
 <1372755849-19546-2-git-send-email-voice.shen@atmel.com>
Message-ID: <51D2F0FA.6040409@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2013 11:04 AM, Bo Shen wrote:
[...]
> +	dma_params->substream = substream;

Unrelated to this patch, but having a substream field in the dma_params seems
to be redundant, since you need to know the substream to get the dma_params in
the first place. Looking at the code it also seems to be unused other than this
assignment. Maybe you can send a follow up patch to remove it.

[...]

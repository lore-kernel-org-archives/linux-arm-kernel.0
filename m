From: timur@tabi.org (Timur Tabi)
Date: Wed, 13 Nov 2013 07:11:32 -0600
Subject: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
In-Reply-To: <201311130931.16238.jbe@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
 <201311130931.16238.jbe@pengutronix.de>
Message-ID: <52837A84.4010900@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

J?rgen Beisert wrote:
> -#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
> +#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | \
>   		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
>   		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
> -		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
> +		    CCSR_SSI_SIER_RIE | \
>   		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
>
>   /**

NACK, this will break PowerPC.

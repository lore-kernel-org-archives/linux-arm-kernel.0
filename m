From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 12 May 2012 12:31:28 +0530
Subject: [PATCH 3/7] mmc: dw_mmc: add device tree support
In-Reply-To: <Pine.LNX.4.64.1205040047280.18111@axis700.grange>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
 <Pine.LNX.4.64.1205040047280.18111@axis700.grange>
Message-ID: <CAJuYYwQj7gzZ9piJAJLcf7SiyJnQ6nZ63-X9ieQ-FCj6TNhQPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2012 04:18, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>
> What do you think about this patch
>
> http://www.spinics.net/lists/linux-sh/msg11259.html
>
> and about using mmc-generic OF properties instead of creating yet another
> copy of proprietary ones?

Hi Guennadi,

This patch does not intend to add any custom mmc properties. I checked
your patch (in the link mentioned above) and most of the bindings are
similar to what you have come up with except for the "ro-gpios" for
which I have used "wp-gpios". But this is following what Arnd had
proposed here: http://www.spinics.net/lists/linux-mmc/msg13564.html.

Regarding the MMC_CAP_4_BIT_DATA and MMC_CAP_8_BIT_DATA in your patch,
these can be derived from the bus width information that the driver
receives.

Thanks,
Thomas.

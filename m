From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 12 May 2012 21:31:31 +0200 (CEST)
Subject: [PATCH 3/7] mmc: dw_mmc: add device tree support
In-Reply-To: <CAJuYYwQj7gzZ9piJAJLcf7SiyJnQ6nZ63-X9ieQ-FCj6TNhQPQ@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
 <Pine.LNX.4.64.1205040047280.18111@axis700.grange>
 <CAJuYYwQj7gzZ9piJAJLcf7SiyJnQ6nZ63-X9ieQ-FCj6TNhQPQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1205122117340.11826@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

On Sat, 12 May 2012, Thomas Abraham wrote:

> On 4 May 2012 04:18, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > What do you think about this patch
> >
> > http://www.spinics.net/lists/linux-sh/msg11259.html
> >
> > and about using mmc-generic OF properties instead of creating yet another
> > copy of proprietary ones?
> 
> Hi Guennadi,
> 
> This patch does not intend to add any custom mmc properties. I checked
> your patch (in the link mentioned above) and most of the bindings are
> similar to what you have come up with except for the "ro-gpios" for
> which I have used "wp-gpios". But this is following what Arnd had
> proposed here: http://www.spinics.net/lists/linux-mmc/msg13564.html.

Thanks for the link! I didn't know about that patch.

> Regarding the MMC_CAP_4_BIT_DATA and MMC_CAP_8_BIT_DATA in your patch,
> these can be derived from the bus width information that the driver
> receives.

Sure. I think, my patch, that I mentioned above, shall be dropped, at 
least in its present form. But if at least in principle we do want to have 
a common MMC OF parser for common bindings, some code from your patch 
would become redundant, I think. BTW, isn't this

+	gpio = of_get_named_gpio(np, "wp_gpios", 0);

a typo? Shouldn't it be "wp-gpios" instead?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

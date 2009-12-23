From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Dec 2009 09:34:58 +0800
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
	<f17812d70912220541g33cdfcffs6b2e51af805ae7b9@mail.gmail.com>
	<20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d70912221734i419af650p78b676b36edb424a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 3:59 AM, Marc Zyngier <maz@misterjones.org> wrote:
> On Tue, 22 Dec 2009 21:41:51 +0800
> Eric Miao <eric.y.miao@gmail.com> wrote:
>
> Eric, Haojian,
>
>> Marc Zyngier was doing the similar thing, and submitted a patch to
>> Andrew Morton already, but I prefer a full-functional IRQ chip based
>> solution, so you may want to work with him together on this.
>>
>> Marc,
>>
>> Do you have the link to your patch?
>
> Here's the current state of my tree, quickly rebased to 2.6.33-rc1.
> To summarize, the main differences with Haojian's patch:
> - uses threaded irqs/nested irqs
> - setup is slightly more complicated (interrupt source mask and base
> ?interrupt number), but more correct (no dependency on gpio_to_irq()
> ?being a linear mapping, which is not always the case)
>

Marc,

This looks good work to me.

Haojian,

Could you help review this patch and see if there's any gap that needs
to be filled to support the platforms on your side?

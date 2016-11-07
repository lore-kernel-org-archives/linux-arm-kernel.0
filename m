From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 07 Nov 2016 17:02:54 +0100
Subject: [PATCH RFC 4/7] ASoC: samsung: i2s: Do not use platform_data for
 DMA parameters
In-Reply-To: <201611050029.18984.arnd@arndb.de>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-6-git-send-email-s.nawrocki@samsung.com>
 <CGME20161104232949epcas4p30f2bceb3a6c95c10661b68d7bf4d4e99@epcas4p3.samsung.com>
 <201611050029.18984.arnd@arndb.de>
Message-ID: <c4388f30-702b-895b-5280-6fabf8e7bfe1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2016 12:29 AM, Arnd Bergmann wrote:
> On Friday 04 November 2016, Sylwester Nawrocki wrote:
>> > -       ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
>> > +       ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
>> >                                                  NULL, NULL);
>
> If we remove the filter argument from every caller here, maybe we should also
> change the prototype to not expect those three NULL arguments any more.

There is one occurrence where the third argument needs to be not NULL.
I'm planning to modify sound/sound/samsung/i2s.c so there is no need
to create another platform device just for the overlay DAI, afterwards
the above function could be simplified.

-- 
Thanks,
Sylwester

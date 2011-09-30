From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Sep 2011 11:30:08 +0800
Subject: [PATCH 1/5] ARM: pxa: remove redundant macro on GPIO
In-Reply-To: <CAMPhdO_Lwi1737PTB=TFoHa8rHyyutkGc-GdUNapJOf6XkG4yg@mail.gmail.com>
References: <1317309546-19682-1-git-send-email-haojian.zhuang@marvell.com>
	<CAHXqBFJnS7-x-Q8aJhNhbbVHhFHWS4PTVb0369p2H42Tm4J=HQ@mail.gmail.com>
	<CAMPhdO_Lwi1737PTB=TFoHa8rHyyutkGc-GdUNapJOf6XkG4yg@mail.gmail.com>
Message-ID: <CAN1soZyNZf71hFbobZqiKmZ8d86c+333DaLkAEWCu+jc6+tFgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/30 Eric Miao <eric.y.miao@gmail.com>:
> 2011/9/30 Micha? Miros?aw <mirqus@gmail.com>:
>> 2011/9/29 Haojian Zhuang <haojian.zhuang@marvell.com>:
>> [...]
>>> ? ? ? ?if (type & IRQ_TYPE_EDGE_RISING)
>>> - ? ? ? ? ? ? ? GRER0 |= GPIO_bit(gpio);
>>> + ? ? ? ? ? ? ? GRER(gpio) |= GPIO_bit(gpio);
>> [...]
>>
>> This looks wrong. There are more occurrences like this. Can you
>> explain if this is correct?
>
> This is actually correct. In GRER(x) - x designates the GPIO instead
> of the subindex n in GRERn.
>
> The rest of the direct references GPxRn have been mostly removed
> during the last several rounds of cleanup.
>
> Haojian,
>
> Please use
>
> 'git grep GP.R[0-9]'
>
> and
>
> 'git grep GR.R[0-9]'
>
> to rule out the rest references. I'm good with the patch, just to
> make sure there is no more such reference.
>
There's no reference to GP.R and GR.R registers except for comment.

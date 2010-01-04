From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 3 Jan 2010 22:29:26 -0500
Subject: [patch 2/4] [ARM] mmp: support marvell ARMADA610
In-Reply-To: <f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
References: <771cded00912062219p79048babs669abf275419a2b9@mail.gmail.com>
	<f17812d70912281949r57e1ca83q65c3fb38c4675056@mail.gmail.com>
	<771cded00912310642x5ffeb071pcf6ade605138bb63@mail.gmail.com>
	<f17812d70912311946n42b6eb13q78afdbd92d2708e9@mail.gmail.com>
	<771cded01001031827j28dc6aa9l5425669f2ceeb27a@mail.gmail.com>
	<f17812d71001031849y294b0a99jdde0aa3e504a04fe@mail.gmail.com>
Message-ID: <771cded01001031929w688217d3g257b395f7544ee7a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> It really hurt performance a lot. While the difference between MMP series
>>> is just the offset of the IRQ_NUM register, it could be calculated in
>>> get_irqnr_preamble, which doesn't have to be executed each time
>>> in the IRQ handling loop. See arch/arm/kernel/entry-armv.S
>>
>> get_irqnr_preamble can only carries one base parameter and one tmp
>> parameter. base parameter is already used for interrupt control
>> register. Only one tmp parameter is left for use. If we want to check
>> chip id, one parameter is not enought.
>>
>
> I'm a bit confused, but those are just registers that the macro is able to use,
> not something as parameters??
>

I could totaly use two parameters / registers. One is already used for
irq controller. Loading the value from irq controller register needs
one register. Storing camparison needs another register. At least, I
need two registers except irq controller register. But there's no
enough parameter / register in get_irqnr_preamble.

Thanks
Haojian

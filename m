From: davem@davemloft.net (David Miller)
Date: Wed, 06 Dec 2017 09:39:02 -0500 (EST)
Subject: [PATCH net-next 2/2 v6] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <CACRpkdbbcG8E6OCPb0Hgmp3owZqn2ab3hWEp1auwj-W_hMVbWw@mail.gmail.com>
References: <20171202110640.5284-2-linus.walleij@linaro.org>
 <20171203.182149.1898604535140297695.davem@davemloft.net>
 <CACRpkdbbcG8E6OCPb0Hgmp3owZqn2ab3hWEp1auwj-W_hMVbWw@mail.gmail.com>
Message-ID: <20171206.093902.2175928679170083415.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Dec 2017 14:02:49 +0100

> On Mon, Dec 4, 2017 at 12:21 AM, David Miller <davem@davemloft.net> wrote:
> 
>>> +static irqreturn_t gemini_port_irq_thread(int irq, void *data)
>>> +{
>>> +     struct gemini_ethernet_port *port = data;
>>> +     struct gemini_ethernet *geth = port->geth;
>>> +     unsigned long irqmask = SWFQ_EMPTY_INT_BIT;
>>> +     unsigned long flags;
>>
>> Always order local variables in reverse-christmas-tree format,
>> which is longest to shortest line.
> 
> It's hard to do in cases like this where I use the variable
> when defining another variable:
> 
> struct gemini_ethernet_port *port = netdev_priv(netdev);
> void __iomem *status_reg = port->gmac_base + GMAC_STATUS;
> 
> But I understand the aesthetic, so I fix it as well as I can.
> 
> If you want me to even rewrite the above using more lines of code
> to keep the aestetic (moving assignment out of the variable
> definitions), tell me and I can fix that too, whatever you like.

Yes, that is the way generally we recommend doing this.  Move
the troublesome assignment down into the actual function body.

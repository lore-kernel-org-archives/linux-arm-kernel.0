From: itooo@itooo.com (Greg)
Date: Tue, 07 May 2013 18:01:14 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <51891D53.1030106@free-electrons.com>
References: <51890C29.8000504@itooo.com> <51891D53.1030106@free-electrons.com>
Message-ID: <5189254A.7010703@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/05/2013 17:27, Maxime Ripard a ?crit :
> Hi Greg,
>
> Le 07/05/2013 16:14, Greg a ?crit :
>> Thomas, Willy,
> I'm not familiar with the Marvell code, so I won't be able to answer
> your question, but the usual way of getting someone's attention is to
> send him a mail directly, while keeping the list in Cc.
>
> There's a high risk of your mail being overlooked or answered to very
> late if you don't do so.
>
>
Thanks for the advice!

By the way, the problem might not be marvell-related since the irq 
number is given by :
> irq_of_parse_and_map(dn, 0);

I enabled debug output in drivers/of/irq.c and it reads :
> of_irq_map_one: dev=/soc/ethernet at d0070000, index=0
>  intspec=8 intlen=1
>  intsize=1 intlen=1
> of_irq_map_raw: par=/interrupt-controller at d0020000,intspec=[0x00000008 
> 0x00000003...],ointsize=1
> of_irq_map_raw: ipar=/interrupt-controller at d0020000, size=1
>  -> addrsize=1
>  -> got it !

I'll continue digging into this once the headache I got while reading 
the code is gone ;-)

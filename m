From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Jan 2015 13:39:03 +0100
Subject: [PATCH v3 2/4] clk: mediatek: Add initial common clock support
 for Mediatek SoCs.
In-Reply-To: <1420685701.27952.44.camel@mtksdaap41>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-3-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeLQkTBYWkBWAYXjYudMAza+1zueRSqGFPd+480p1rYNwg@mail.gmail.com>
 <1420685701.27952.44.camel@mtksdaap41>
Message-ID: <CABuKBeLFvP4ChnzzUJwoLtCHtH6PejENJueBd7D+xMJhBMDBkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-08 3:55 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
> Hi Matthias,
>
> On Wed, 2015-01-07 at 18:22 +0100, Matthias Brugger wrote:
>> 2015-01-07 4:25 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
[...]
>> > +
>> > +extern spinlock_t *get_mtk_clk_lock(void);
>> > +
>> > +#define mtk_clk_lock(flags)    spin_lock_irqsave(get_mtk_clk_lock(), flags)
>> > +#define mtk_clk_unlock(flags)  \
>> > +       spin_unlock_irqrestore(get_mtk_clk_lock(), flags)
>>
>> Please use the spinlock directly without this akward defines.
>
> Do you mean we should export clk_ops_lock (from clk-mtk.c) directly
> instead of get_mtk_clk_lock()? Or simply remove mtk_clk_lock/unlock()?
>

I think you should use spin_lock_irqsave(&clk_ops_lock, flags) instead
of mtk_clk_lock.
In any case I think you should define a spinlock in clk-mt8135.c and
pass a reference of it in the init functions.
See drivers/clk/berlin as a good example.

Thanks,
Matthias

-- 
motzblog.wordpress.com

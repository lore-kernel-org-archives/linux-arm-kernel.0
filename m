From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 22 Sep 2011 11:30:33 +0530
Subject: [PATCH v16 10/12] OMAP: dmtimer: extend spinlock in request
	functions
In-Reply-To: <20110922004243.GL2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-11-git-send-email-tarun.kanti@ti.com>
	<20110922004243.GL2937@atomide.com>
Message-ID: <CAC83Zv+W+RmnuXaMdGwBOfHYY0undQTxCTa8OgiO5P8G3Nr0tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 6:12 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> The request functions now verify the success of omap_dm_timer_prepare() call
>> after a timer is acquired. If *_prepare() fails then we have to release the
>> timer. In order to avoid race condition during this time, include *_prepare()
>> within lock.
>
> This I've folded into patch 5.
That should be fine.
--
Tarun
>
> Tony
>

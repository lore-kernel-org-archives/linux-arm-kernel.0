From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Aug 2017 05:27:45 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
Message-ID: <20170827032745.GC13622@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 27, 2017 at 04:30:08AM +0200, Andreas F?rber wrote:
> Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
> > n Sun, Aug 27, 2017 at 02:33:27AM +0200, Andreas F?rber wrote:
> >> +struct rtd119x_rtc {
> >> +	void __iomem *base;
> >> +	struct clk *clk;
> >> +	struct rtc_device *rtcdev;
> >> +	unsigned base_year;
> >> +	spinlock_t lock;
> > 
> > Where is this lock initialised? I would expect a call to
> > spin_lock_init() somewhere.
> 
> Hm, the spinlock in my irq mux series doesn't have that call either; my
> reset driver did have it. The zero initialization appears to work OK,
> but you're probably right that it should be there.

Hi Andreas

I suspect you will have problems if you enable spin lock debug code,
like CONFIG_DEBUG_SPINLOCK.

     Andrew

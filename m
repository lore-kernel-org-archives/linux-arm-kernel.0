From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 2 May 2011 11:46:16 +0200
Subject: [PATCH 1/3] i2c: append hardware lock with bus lock
In-Reply-To: <20110502092734.GV15795@trinity.fluff.org>
References: <1304003746-12127-1-git-send-email-haojian.zhuang@gmail.com>
	<20110502092734.GV15795@trinity.fluff.org>
Message-ID: <20110502114616.7813da79@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 May 2011 10:27:34 +0100, Ben Dooks wrote:
> On Thu, Apr 28, 2011 at 11:15:44PM +0800, Haojian Zhuang wrote:
> > Both AP and CP are contained in Marvell PXA910 silicon. These two ARM
> > cores are sharing one pair of I2C pins.
> > 
> > In order to keep I2C transaction operated with atomic, hardware lock
> > (RIPC) is required. Because of this, bus lock in AP side can't afford
> > this requirement. Now hardware lock is appended.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Jean Delvare <khali@linux-fr.org>
> 
> Right, this looks like a reasonable explanation of what is going on here
> and if Jean is happy with the core changes I'll look at where the driver
> change can go.

Yes I am!

Let me know if you want me to take the core change in my tree or if you
prefer to have it in yours to avoid a dependency.

-- 
Jean Delvare

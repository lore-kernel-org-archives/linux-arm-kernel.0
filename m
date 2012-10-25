From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 08:21:06 +0200
Subject: [PATCH 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <20121024.230648.1888101216213031807.davem@davemloft.net>
References: <1351011300-26964-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351011300-26964-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024.230648.1888101216213031807.davem@davemloft.net>
Message-ID: <20121025082106.4041f340@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, 24 Oct 2012 23:06:48 -0400 (EDT), David Miller wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date: Tue, 23 Oct 2012 18:54:57 +0200
> 
> > +	u32 cause_rx_tx[CONFIG_NR_CPUS];
> 
> Please use per-cpu variables instead of explicitly sized
> arrays.

Ok, thanks. In fact, this per-cpu array is not needed in the current
version of the driver, it will only be needed when we make improvements
to it that bind RX queues to specific CPUs. So for now, I'll get rid of
it.

I'll wait a bit more to see if there are any comments, and I'll repost
an updated v4 of the patches.

Thanks a lot for your review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

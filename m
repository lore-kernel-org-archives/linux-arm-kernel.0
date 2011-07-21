From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:02:55 +0100
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY193Tg1XfnkK3GYYaYWmZYRgeqnGnS_dNC4H1TFTGO_pA@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
	<20110721112920.GM26574@n2100.arm.linux.org.uk>
	<CABb+yY2p8VNSvhv+LjoYnunrYS8+3+841bKM-4aUsg5vNx=Mig@mail.gmail.com>
	<20110721152342.GE28942@n2100.arm.linux.org.uk>
	<CABb+yY193Tg1XfnkK3GYYaYWmZYRgeqnGnS_dNC4H1TFTGO_pA@mail.gmail.com>
Message-ID: <20110721160255.GQ26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 09:26:22PM +0530, Jassi Brar wrote:
> Though you might want to consider changing the DMA_SLAVE_CONFIG API from
> optional to mandatory for Slave capable DMACs. Otherwise I don't see common
> client drivers working over different DMACs.

Yes, I think we will have to, otherwise we can't ensure we have cross-
compatibility between different DMA engine implementations.

We already have platforms where we have peripheral drivers making use of
several different DMA engine implementations, so nailing this down now,
before the number of DMA engine implementations increases still further
is definitely something that needs doing.

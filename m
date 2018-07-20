From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Fri, 20 Jul 2018 20:12:05 +0200
Subject: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction once
 per transfer
In-Reply-To: <20180719082318.290abee1@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-4-jmkrzyszt@gmail.com>
 <20180719082318.290abee1@bbrezillon>
Message-ID: <90128326.sKM4evrj8F@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 19, 2018 8:23:18 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:05 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > In its current shape, the driver sets data port direction before each
> > byte read/write operation, even during multi-byte transfers.  Optimize
> > that by setting the port direction only on first byte of each transfer.
> 
> Sounds like premature optimization for something you'll rework when
> fully switching to the GPIO consumer API to control the DATA bus.

Indeed, this optimization was crucial for getting acceptable performance of 
data transfers over GPIO.  I'm only not sure if there is any action in 
response to your comment expected on my side, e.g., did you want to say I 
should modify the patch description, or change the order of patches?

Thanks,
Janusz

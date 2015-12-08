From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 22:34:42 +0100
Subject: [PATCH] soc: TI knav_qmss: fix dma_addr_t printing
In-Reply-To: <56670B21.5060209@oracle.com>
References: <2560281.KhcNzi0XgD@wuerfel> <56670B21.5060209@oracle.com>
Message-ID: <18371096.H4qt47cWYH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 08:53:53 santosh shilimkar wrote:
> On 12/8/2015 7:30 AM, Arnd Bergmann wrote:
> > The knav_qmss driver is currently broken when CONFIG_LPAE is
> > set, which is a bit surprising because I'd expect that any serious
> > users of this platforms would have more than 2GB of RAM and require
> > LPAE.
> >
> Well it has been working with LPAE enable always. The production
> systems do but IIRC, some of the Eval board were still build with
> just 2 GB memory.

Maybe that just means that the debug code is never used and we can remove
all the dev_dbg instead? That might actually be nicer as it would reduce
the amount of code in your driver (slightly).

	Arnd

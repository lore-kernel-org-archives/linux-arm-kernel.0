From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 11:21:53 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <CAN1soZwwr21=JV=NE81aey-1nSMzg-37fXG7zjouALJaU345Fg@mail.gmail.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071014.03632.arnd@arndb.de>
 <CAN1soZwwr21=JV=NE81aey-1nSMzg-37fXG7zjouALJaU345Fg@mail.gmail.com>
Message-ID: <201205071121.53302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Haojian Zhuang wrote:
> Even we append a new IORESOURCE type. We still meet similar issue. So
> it means that we can't use any IORESOURCE for this kind of i2c usage. Is
> it right?

Yes, basically the concept of IORESOURCE is incompatible here, unless you
want to add a new IORESOURCE type for each one of these drivers, or you
find a way to put all these devices into one global register space at
unique addresses, which doesn't sound any better.

Can you explain why you need this kind of arbitration to start with?
Can't you just ensure that each client of the max8925 only sees a fixed
set of nonconflicting registers, and provide a higher-level abstractions
for the registers that are indeed shared between clients?

Wouldn't you always know which drivers potentially coexist here?

	Arnd

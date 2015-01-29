From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 23:28:15 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <CAPybu_0OWLZeEFMByrrDg7HOfjAYbOnAoazLac-E8KV-mKSJSg@mail.gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
 <2800334.5ezTSQFkNQ@wuerfel>
 <CAPybu_0OWLZeEFMByrrDg7HOfjAYbOnAoazLac-E8KV-mKSJSg@mail.gmail.com>
Message-ID: <2357790.QEsOKkOOBx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 23:14:46 Ricardo Ribalda Delgado wrote:
> What about the different return type? u8 vs int

Too many drivers use all sorts of different types, I've given up
hope of changing drivers to agree on the same type here. Basically
you can think of 'void __iomem *' as the magic keyword for something
that gets returned from ioremap, can take an integer offset and gets
passed into readb/readw/readl/write..., but any other assumption beyond
that is dangerous.

	Arnd

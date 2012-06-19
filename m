From: josh.coombs@gmail.com (Josh Coombs)
Date: Tue, 19 Jun 2012 17:32:35 -0400
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
In-Reply-To: <20120619191820.GA28139@lunn.ch>
References: <20120619191820.GA28139@lunn.ch>
Message-ID: <CAMW5UfZ4YVj4DBiGDL6t2vRJEtUikOVS9kpGOCQqHuruxLzQmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 3:18 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Josh
>
> I think i know why your machine locks up.
>
> Your board file defines goflexnet_partitions but then never uses
> it. So you have no SPI nor NAND device in operation. Without one of
> these two, there is nothing using the RUNIT clock, so it gets turned
> off. There appears to be something else in the RUNIT, so turning the
> clock off causes the next access to what ever that is, to lock the
> machine.
>
> Try applying this patch:
>
> http://www.spinics.net/lists/arm-kernel/msg178389.html
>
> ? ? ? ?Andrew

You nailed it, I'm up and running in 3.5rc3 as we speak.  I'll make
the cleanups suggested for the initial version of my DTS patch, test
in conjunction with yours and the printk patch and then submit.  I'll
then work on getting the NAND supported.

http://pastie.org/4116846

Josh Coombs

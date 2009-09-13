From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Sep 2009 23:58:35 +0100
Subject: 'bx lr' vs 'mov pc,lr'
In-Reply-To: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
References: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
Message-ID: <20090913225835.GB30169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 12:55:24AM +0300, Felipe Contreras wrote:
> I noticed that in 'arch/arm/lib/delay.S' we are using 'mov pc, lr'
> instead of 'bx lr'. Why? It looks like 'mov pc, lr' is used all over
> the place, but I can't find out what's the reason.

Why do you want bx?  bx isn't available on older CPUs.

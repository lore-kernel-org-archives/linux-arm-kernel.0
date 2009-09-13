From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Sun, 13 Sep 2009 23:15:00 +0100
Subject: 'bx lr' vs 'mov pc,lr'
In-Reply-To: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
References: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
Message-ID: <20090913221500.GB5398@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 12:55:24AM +0300, Felipe Contreras wrote:
> I noticed that in 'arch/arm/lib/delay.S' we are using 'mov pc, lr'
> instead of 'bx lr'. Why? It looks like 'mov pc, lr' is used all over
> the place, but I can't find out what's the reason.

I'd guess at the reason being that not all ARM processors whose ports use
arch/arm/lib/delay.S support the bx instruction, whereas the 'mov pc, lr'
instruction is universally supported.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/

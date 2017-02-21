From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Feb 2017 17:12:23 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75VfHf9qN+sRd6cymr9ziO9Xi7gw+O-yOp+1zEAduxEMfJg@mail.gmail.com>
References: <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221122050.421dae48@bbrezillon>
 <CAHp75VfHf9qN+sRd6cymr9ziO9Xi7gw+O-yOp+1zEAduxEMfJg@mail.gmail.com>
Message-ID: <20170221161223.neimpmqfvb5lvozp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/2017 at 17:55:15 +0200, Andy Shevchenko wrote:
> > And how do you do with new drivers?
> 
> To be more pedantic the new drivers do not have "minus" thousands LOC.

Because all the "minus" are located in the same file (the one that
disappear), they can be safely ignored. So it is basically the same as
having a new driver.

> > I'm regularly reviewing drivers that are
> > several thousands LOC, and I don't ask people to split things just
> > because it's too long. When I ask them to split in different commits,
> > it's because they are doing several unrelated changes at once.
> 
> What did prevent you to:
> 1. Introduce new driver
> 2. Switch to new driver
> 3. Remove old one.
> 
> ...if you are not splitting it in the first place?
> 

Having a new Kconfig symbol and switching to it, then switching to the
previous one to avoid breaking existing configurations. That's a lot of
churn for exactly 0 benefit because as said, you can safely ignore the
removed file when reviewing.

> > Note that I considered refactoring the existing driver in smaller
> > steps, but it's almost impossible, because the code is too messy and I
> > would end up with a huge series of patches that is not easier to review.
> 
> I can object this, but it will be no point except waste of time to
> this discussion.
> 
> It's good that you considered several options. I suppose someone who
> is on topic can do comprehensive review.
> 

Maybe the NAND subsystem maintainer can review the change... oh,
wait...nevermind.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

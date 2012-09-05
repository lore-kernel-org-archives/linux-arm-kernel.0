From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 05 Sep 2012 07:53:25 +0200
Subject: [PATCH v2 5/5] ARM: Exynos: Add basic dts file for Samsung Trats
 board
In-Reply-To: <CAJuYYwTV1giNYJ7RTz=DHqK=i6FD2GsV4rNY2p5scVAnQz0kdg@mail.gmail.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1346748609-11115-6-git-send-email-t.figa@samsung.com>
 <CAJuYYwTV1giNYJ7RTz=DHqK=i6FD2GsV4rNY2p5scVAnQz0kdg@mail.gmail.com>
Message-ID: <3039444.Ol4zGlGWJ2@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for reviewing the patch.

On Wednesday 05 of September 2012 09:35:49 Thomas Abraham wrote:
> > +
> > +       memory {
> > +               reg =  <0x40000000 0x20000000
> > +                       0x60000000 0x20000000>;
> > +       };
> 
> Why does this have to be split. Why not have a single entry with the
> size as 0x40000000?

The memory node corresponds to struct meminfo and each entry (with two 
values) makes one struct membank defining a memory bank.

I've been talking with Kyungmin about this. Originally bootloaders used to 
report 4 banks of 256 MiB, but it turned out that real bank configuration 
on Trats is 2 banks of 512 MiB.

I'm not into memory management internals, so I don't know if this has any 
significance, but I defined the node to represent the real configuration 
(otherwise I would have probably used 4 banks of 256 MiB and drop the 4th 
patch).

> > +               max8997_pmic at 66 {
> > +                       compatible = "maxim,max8997-pmic";
> > +
> > +                       reg = <0x66>;
> 
> Probably, the interrupts can be listed when we have pinctrl driver
> merged in Samsung tree.
> 

Right.

--
Best regards,
Tomasz Figa

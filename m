From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 2 Jul 2014 13:48:53 +0200
Subject: [PATCH v2 0/2] ARM: at91: remove phy fixup for sama5d3xek boards
In-Reply-To: <20140701.153806.1074873302413556163.davem@redhat.com>
References: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140701.153806.1074873302413556163.davem@redhat.com>
Message-ID: <20140702134853.43d624c9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello David,

On Tue, 01 Jul 2014 15:38:06 -0700 (PDT)
David Miller <davem@redhat.com> wrote:

> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Date: Thu, 26 Jun 2014 12:13:33 +0200
> 
> > This patch removes a board specific hook for sama5d3xek boards from
> > the sama5d3 generic DT board file.
> > 
> > This hook (which register a phy fixup configuring board specific
> > delays in the ksz9021 ethernet phy) is now replaced by the
> > appropriate DT properties definitions in the sama5d3xcm.dtsi file.
> > 
> > Changes since v1:
> >  - fix txc-skew-ps and rxc-skew-ps delays
> >  - remove phy address info to handle Ronetix and Embest HW designs
> 
> These patches do not apply cleanly to 'net' nor 'net-next', in fact
> you did not even say which tree these changes are targetting.

Actually, these patches were intended to be taken through at91 (and then
arm-soc) tree.

The reason I added netdev in Cc is because I wanted to get feedback on
the DT phy node definition (which I got from Florian).

I guess patch 2 does not apply cleanly because I based this work on top
of other changes which are not merged yet ([1]).

Nicolas, I'll take care to rebase this series on top of linus/master
branch (or whatever branch you want me to base it onto).

Thanks,

Boris

[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265216.html

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

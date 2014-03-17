From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 17 Mar 2014 17:47:06 -0300
Subject: [PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
In-Reply-To: <532748C2.9030009@gmail.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <532748C2.9030009@gmail.com>
Message-ID: <20140317204706.GB1118@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 17, Sebastian Hesselbarth wrote:
> On 03/15/2014 07:17 PM, Ezequiel Garcia wrote:
> >Fourth round of the patchset adding support for watchdog on Armada 375 and
> >Armada 38x SoCs.
> >
> >The new Armada 375/385 SoCs have two registers for the watchdog RSTOUT:
> >
> >  1. It has a dedicated register (similar to the one in A370/XP)
> >  2. Also has a bit in a shared RSTOUT register.
> >
> >Therefore, in order to support this two-folded RSTOUT, we extend the 'reg'
> >property in the watchdog devicetree and require a new pair of cells to specify
> >the shared RSTOUT.
> >
> >On the driver side, we need to implement per-SoC stop() and enabled()
> >functions. Such somewhat complex infrastructure is needed to ensure the driver
> >performs proper reset of the watchdog timer, by masking and disabling the
> >RSTOUT before the interrupt is enabled.
> >
> >I've pushed a branch so people can test this easily, e.g. ensuring
> >no regressions on Dove, Kirkwood and A370/XP:
> 
> Ezequiel,
> 
> Although, I just saw below that you actually already tested on Dove,
> you can add my
> 
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 

Great, thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

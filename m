From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 9 Apr 2015 17:57:35 +0200
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <55269C05.2060401@gmail.com>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
 <55269C05.2060401@gmail.com>
Message-ID: <20150409175735.342d0111@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thu, 09 Apr 2015 17:34:29 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> 
> if you include a bunch of performance measurements, I guess it will help
> you to get an agreement of replacing the driver instead of reworking it.

Yep, I made some measurements using tcrypt a while ago, I'll provide
them in the next round.

> 
> > Here are the main features brought by this new driver:
> > - support for armada SoCs (up to 38x) while keeping support for older ones
> >    (Orion and Kirkwood)
> 
> Unfortunately, the list above is missing Dove SoCs which also have a
> CESA engine with TDMA support. I checked the registers _very_ quickly
> but it seems that they are compatible with Kirkwood's CESA.

I checked it too: it should work, but I don't have any board to test
it :-/.

> 
> > - DMA mode to offload the CPU in case of intensive crypto usage
> > - new algorithms: SHA256, DES and 3DES
> >
> [...]
> > Boris Brezillon (2):
> >    crypto: add new driver for Marvell CESA
> >    crypto: marvell/CESA: update DT bindings documentation
> 
> IMHO, the patch set should be split up in:
> - new core driver
> - add support for TDMA on platforms that support it
> - new cipher algorithms
> - removal of old mv_cesa

I agree for the 2 steps operation:
- add new driver code without compiling it
- remove old code, update Kconfig (add new dependencies) and Makefile
  entries (compile the code in marvell/ instead of mv_cesa.c)

Is there a good reason for separating the core, TDMA and algorithms
support in different patches (keep Arnaud's authorship ?) ?
Anyway, this should be feasible, but I thought the policy was to
minimize the number of patches when submitting new drivers.

> 
> I'd love to test on Dove, but time still is very limited. I guess the
> patches will receive another round anyway, maybe I find some until the
> final version.

No problem (thanks for the offer).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

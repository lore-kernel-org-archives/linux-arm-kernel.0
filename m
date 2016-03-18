From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Mar 2016 20:33:52 +0000
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <20160318202310.GS30977@lukather>
References: <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
 <20160318202310.GS30977@lukather>
Message-ID: <20160318203352.GL2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 09:23:10PM +0100, Maxime Ripard wrote:
> On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:

> > Very few device drivers would work with 63byte transfers only and the
> > code for manually driving the CS line in case the DMA engine fails to
> > configure will necessarily go untested most of the time since most
> > systems will have DMA configured properly.

> That's not true. A significant portion would work. I don't like to
> make up numbers, but I guess only the EEPROMs and rather big screens
> wouldn't work.

You'll probably also see devices doing things like firmware downloads,
there's a bunch of applications for larger transfers.  Like you say it's
definitely not going to be a universal problem though, there's many
devices that just use SPI for fast register access.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160318/362e88e2/attachment.sig>

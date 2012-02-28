From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 28 Feb 2012 14:23:14 +0000
Subject: [GIT PULL] DaVinci cleanups for v3.4
In-Reply-To: <201202271459.52216.arnd@arndb.de>
References: <DF0F476B391FA8409C78302C7BA518B6317D2DB9@DBDE01.ent.ti.com>
 <201202271459.52216.arnd@arndb.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317D6BF8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Feb 27, 2012 at 20:29:52, Arnd Bergmann wrote:
> On Friday 24 February 2012, Nori, Sekhar wrote:
> > Hi Arnd, Olof,
> > 
> > Can you please pull these DaVinci clean-up patches for
> > the v3.4 merge window? I have made sure that these don't
> > have any conflicts with the rmk/for-armsoc branch of
> > the arm-soc tree.
> > 
> > These patches need the following two commits from linux-next
> > (next-20120224) to keep the VPIF and CQ93VC drivers building.
> > 
> > 2e932f2  ASoC: CQ93VC: remove machine specific header file inclusion from codec
> > db38951  [media] davinci: vpif: remove machine specific header file includes
> 
> In general, don't worry too much about conflicts that are easy to
> resolve. However, having these extra dependencies is not good,
> because it means that we cannot easily build-test the arm-soc
> tree by itself and it breaks bisection through the git history.
> 
> In the future, please make sure that dependent commits show up
> in the right order. For now, I've added the patch below on top
> of your series.

I guess the cleanest way to do that would have been to let
these patches go through my tree with appropriate maintainer
acks (but that obviously didn't happen - will try and fix
that for future). Per my understanding, it is encouraged that
a patch should get applied only through one tree, so I was
reluctant to apply them to any of the branches I send to you
after they were already in linux-next through other trees.

Thanks,
Sekhar

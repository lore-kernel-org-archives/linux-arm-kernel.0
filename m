From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 Jul 2012 12:19:48 -0600
Subject: commit 91013923c712e1c: "irqdomain: Replace LEGACY mapping with
 LINEAR" breaks console on ARM i.mx23
In-Reply-To: <20120719192814.75ea8beb784bdf8bb32c510c@kinali.ch>
References: <20120719192814.75ea8beb784bdf8bb32c510c@kinali.ch>
Message-ID: <CACxGe6tUOAtRgV9NHgfLchFAmQH99g0jNh0ANxyKPasbkHn2Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 11:28 AM, Attila Kinali <attila@kinali.ch> wrote:
> Hi,
>
> I'm working on an embedded system based on a Freescale ARM9 processor i.mx23.
>
> While trying linux-next i stumpled over my login prompt getting broken.
> What exactly happens is that the kernel boots normally, but when my
> login prompt should appear it suddenly stops. I bisected it back to
> the commit 91013923c712e1c4b9b343f0ee4a86ce72b1b630
> irqdomain: Replace LEGACY mapping with LINEAR
>
> Reverting this and the three commits that directly depend on it (see below)
> everything seems to work fine again

Mark Brown also noticed this and pointed this out. I'm working on it.
I've pulled those three patches out of my -next branch while I'm
working on the fix.

g.

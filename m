From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sat, 19 Jun 2010 16:23:22 +0200
Subject: [PATCH] orion/kirkwood: reset PCIe unit on boot
In-Reply-To: <20100619140628.GP1573@jirafa.cyrius.com>
References: <1276029158-22159-1-git-send-email-razzor@kopf-tisch.de>
	<20100619140628.GP1573@jirafa.cyrius.com>
Message-ID: <20100619142322.GO14513@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 19, 2010 at 03:06:29PM +0100, Martin Michlmayr wrote:

> > Patch found in QNAPs vendor source package, with some cleanups
> > (proper defines, shortened max. timeout from 1s to 200ms).
> > 
> > Without this patch the PCIe SATA controller (Marvell 88sx7042/sata_mv)
> > in my QNAP TS-419P (Marvell 88f6281/Kirkwood) stops working after a
> > few minutes.
> > The symptomes are described in this thread:
> > http://marc.info/?l=linux-ide&m=124822863706181&w=2
> 
> Nico, Saeed: do you have any comments on this patch?
> 
> A number of Debian users ran into this issue so I'm glad Olaf found a
> solution.

I'm not very happy with it, as (as far as I understand) even though
it might solve the problem, so far it's unclear why exactly it does so.

And consequently, e.g. whether it's needed on other SoCs as well.

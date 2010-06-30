From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Jun 2010 09:33:53 +0300
Subject: [PATCH] ARM: Disable VGA console for ARM in most cases (Re: [PATCH
	1/6] omap: Disable VGA console for omaps)
In-Reply-To: <20100629142144.GN2822@atomide.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
	<20100629114720.16008.84291.stgit@baageli.muru.com>
	<20100629120724.GA23884@oksana.dev.rtsoft.ru>
	<20100629142144.GN2822@atomide.com>
Message-ID: <20100630063352.GR2822@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100629 17:15]:
> * Anton Vorontsov <cbouatmailru@gmail.com> [100629 15:04]:
> > On Tue, Jun 29, 2010 at 02:47:20PM +0300, Tony Lindgren wrote:
> > > Otherwise we have to disable it manually to avoid compile errors.
> > > 
> > > Cc: linux-fbdev at vger.kernel.org
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > We'll need this for mach-cns3xxx too. And doing that change for
> > every ARM subarch is going to produce lots of rejects.
> > 
> > I'd suggest to disable (or make it 'default n') for all ARMs,
> > except these:
> > 
> > $ git grep VGA_CONSOLE= arch/arm/configs/
> > arch/arm/configs/footbridge_defconfig:CONFIG_VGA_CONSOLE=y
> > arch/arm/configs/integrator_defconfig:CONFIG_VGA_CONSOLE=y
> > arch/arm/configs/netwinder_defconfig:CONFIG_VGA_CONSOLE=y
> 
> Good idea, will post a modified patch tomorrow.

Here's this one updated.

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kconfig-disable-vgacon.patch
Type: text/x-diff
Size: 1452 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100630/06631be0/attachment.bin>

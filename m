From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 13:35:04 +0000
Subject: [PATCH 7/7] arm: Add livepatch necessary arch selects into Kconfig
In-Reply-To: <alpine.LSU.2.20.1701181339350.23458@pobox.suse.cz>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-8-git-send-email-abelvesa@linux.com>
 <alpine.LSU.2.20.1701181339350.23458@pobox.suse.cz>
Message-ID: <20170118133504.GL27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 01:40:23PM +0100, Miroslav Benes wrote:
> On Tue, 6 Dec 2016, Abel Vesa wrote:
> > @@ -82,6 +84,7 @@ config ARM
> >  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
> >  	select IRQ_FORCED_THREADING
> >  	select MODULES_USE_ELF_REL
> > +	select MODULES_USE_ELF_RELA
> 
> I wrote it before but I think you cannot have both MODULES_USE_ELF_REL and 
> MODULES_USE_ELF_RELA.

ARM doesn't use RELA relocations, so it's pointless enabling them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

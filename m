From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 5 Feb 2013 11:27:21 -0300
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205124833.GS14746@titan.lakedaemon.net>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
Message-ID: <20130205142720.GB2481@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 07:48:33AM -0500, Jason Cooper wrote:
> Morning-ish Andrew,
> 
> On Tue, Feb 05, 2013 at 01:38:27PM +0100, Andrew Lunn wrote:
> > > And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> > 
> > Maybe it makes sense to provide a patch to mvebu_defconfig to add 
> > CONFIG_MTD_M25P80=y ?
> 
> I thought this as well, then reconsidered when he said there was nothing
> on it.  So it's not really needed to boot.  I don't have a strong
> opinion on it though, so =y, =m, or =n.
> 

Well, the SPI flash may not be empty, if that's what you meant.
For instnace, my Armada XP GP board has the bootloader on that SPI,
and boots from there. After booting, the SPI flash is no longer needed.

IMHO, I don't think we should include the option CONFIG_MTD_M25P80
as it is just a particular SPI master device present in a particular board.

On the other hand, I don't have a strong opinion on this.
I've always wondered the *true* meaning of defconfigs,
so feel free to enligthen me :)

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

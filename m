From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 16:35:07 +0200
Subject: [PATCH] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <20160418142909.GA5608@rob-hp-laptop>
References: <1460360506-14692-1-git-send-email-navam@xilinx.com>
 <4542055.HvdgVkDRYK@wuerfel> <20160418142909.GA5608@rob-hp-laptop>
Message-ID: <4449845.qT8BZnpD4R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 09:29:09 Rob Herring wrote:
> 
> Right, you don't need to know the exact bus width for determining the 
> register/descriptor set is 32 or 64 bit addesses. I'm fine with a 
> property for that, but if limiting the actual connected address bits is 
> needed, then dma-ranges should be used.

The other way round: dma-ranges is needed to allow 64-bit addressing,
the default is to only allow 32-bit addressing (and arm64 has a known
bug here, it just allows it anyway when it shouldn't).

	Arnd

From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 30 Jun 2011 14:36:25 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <20110518214744.GA22034@atrey.karlin.mff.cuni.cz>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518214744.GA22034@atrey.karlin.mff.cuni.cz>
Message-ID: <201106301436.26105.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 18, 2011 11:47:44 PM Cyril Hrubis wrote:
> Hi!
> I've applied this patch over 2.6.39-rc3 and did couple of suspends. After
> about ten of them I've got attached trace (instead of the usuall NULL
> pointer dereference in complete()).
> 
> And yes, the MMC is still broken after this change it seems that there are
> more bugs in zaurus SPI drivers.

Looks like corgi-bl, I think there was a patch for this I had, dunno if it was 
applied.

Eric, was that gpio_set_value_cansleep() for corgi-bl merged ?

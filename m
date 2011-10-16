From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 21:05:28 +0200
Subject: [PATCH 0/11 v3] ARM: AT91: update gpio implementation
Message-ID: <20111016190528.GI1459@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	Today on at91 we use gpio != 0 as non valid gpio instead of the
	-EINVAL as define on the gpiolib so we can not use gpio_is_valid to
	check if a gpio is valid

	This patch series update the GPIO base addr to besoc independant and
	the gpio implemetation to start the first gpio as 0 and set -EINVAL
	for a non valid gpio

	So we will be complatible with the other implemenation as the AVR32

	we also update all the drivers

	v3:

	update against at91-next which contains Thomas Petazzoni USB
	support overcurrent notification

Best Regards,
J.

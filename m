From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 20:16:46 +0100
Subject: [PATCH 2/3] arm: kirkwood: factor pinmux descriptors for
 OpenBlocks A6
In-Reply-To: <20130306181648.GE3904@lunn.ch>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306181648.GE3904@lunn.ch>
Message-ID: <20130306201646.179fce69@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 6 Mar 2013 19:16:48 +0100, Andrew Lunn wrote:

> There is no need to pinmux gpio pins at all. The pinctrl driver does
> it when the gpio driver requests the pins.

Right, that's true. I knew about this, but since the pinmux
configuration was made explicit for those GPIOs, I thought the original
author(s) of this .dts did this intentionally. For example, it somewhat
documents the 8 GPIOs that are available in the bottom connector of the
OpenBlocks A6. They are not tied to anyway particular device, so they
wouldn't appear anywhere in the DT. Ditto for the DIP switch GPIOs. Do
you also want those to be removed from the DT?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jun 2014 11:56:57 +0100
Subject: [PATCH] ARM: integrator: fix section mismatch problem
In-Reply-To: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
References: <1401879202-10516-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140604105657.GA23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 12:53:22PM +0200, Linus Walleij wrote:
> However the module driver model of the Integrator LM bus
> assumes that logic tile drivers can be probed at runtime. This
> is not really the case for IM-PD1: these tiles are detected at
> boot and they cannot be plugged into a running system. Before
> this patch it is of course possible to modprobe them later.

Check whether you can bind/unbind the driver via sysfs.  Merely making
stuff non-modular is really just a hack around this problem where the
device model can be used to bind/unbind devices.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

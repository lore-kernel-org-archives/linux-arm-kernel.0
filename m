From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Mar 2011 14:08:08 +0000
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103092058.34236.arnd@arndb.de>
	<AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
Message-ID: <20110310140807.GB7411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 02:25:19PM +0100, Linus Walleij wrote:

> "platform" means "platform bus" in this context, does it not?
> So your reasoning is that since on SoC:s there is one dominant
> bus called the platform bus that should also hold a reference to the
> SoC-specific stuff.

Lots of stuff (like the MFD children of I2C devices) gets shoved on the
platform bus on Linux - every time someone considers creating a new bus
type for trivial devices the discussion ends up saying that the code
will end up being pretty much identical to the platform bus as it's so
straightforward so there's no point in cut'n'pasting the code.

> So standardizing the location here,
> /sys/devices/system contain these more neutral things:

> /sys/devices/system ls
> clocksource  cpu          timekeeping  timer

> IMHO socinfo fits here, just as it is in the patch.

There's a general idea to kill of the system devices as the fact that
they do special magic and don't have things like a struct device creates
integration problems.

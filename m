From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Jul 2010 13:56:52 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007221410.10087.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<AANLkTinQS3vkua2dW0iPpXKDJizVIIKgqcBol2FhuRW_@mail.gmail.com>
	<201007221410.10087.david.jander@protonic.nl>
Message-ID: <20100722125652.GL10930@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 02:10:09PM +0200, David Jander wrote:

> IMO, if a bootloader is broken (in any way), it needs replacing. Be it with 
> another bootloader or directly with the kernel.

If you don't have JTAG access (either due to device limitations or due
to lack of data from the vendor of a reference platform you're using)
replacing a bootloader can be rather more stressful than it's worth.

> That sounds a lot "saner" to me than having two asynchronous and different 
> copies of setup-code, which could be a potential nightmare, besides not being 
> really maintainable.

Well, from the point of view of using systems like this all you need the
bootloader to do is to set the system up enough to load the kernel and
start it running.  You don't need it to understand anything else about
the rest of the system, which means you're less reliant on the quality
of the bootloader.

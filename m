From: pma@sysgo.com (Pavel Machek)
Date: Wed, 13 Jul 2011 08:15:31 +0200
Subject: [PATCH V3] mmc: Enable the ADMA2 on esdhc imx driver
In-Reply-To: <20110712141843.GA27358@oksana.dev.rtsoft.ru>
References: <1310465609-4516-1-git-send-email-richard.zhu@linaro.org>
	<20110712134602.GT6069@pengutronix.de>
	<20110712141843.GA27358@oksana.dev.rtsoft.ru>
Message-ID: <20110713061531.GA10700@pma.sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2011-07-12 18:18:43, Anton Vorontsov wrote:
> On Tue, Jul 12, 2011 at 03:46:02PM +0200, Sascha Hauer wrote:
> [...]
> > Honestly, putting all kinds of driver logic into the register access
> > functions will lead to a catastrophe sooner or later. There are too
> > many quirks in it already, we should not add more of them.
> 
> There aren't many options. You may pollute generic driver with
> quirks (which is not an option :-), or you can introduce more
> ops for things like sdhci_send_command(), but in that case
> you will duplicate the logic just to compensate minor register
> differences.
> 
> In some cases, e.g. capabilities register, it seems that introducing
> get_caps() op would be a logical step, but then you just move the code
> under 'if (reg == SDHCI_CAPABILITIES) { ' into a dedicated function.
> No big difference.

Actually, there is huge difference. Generic code does
read-modify-write on the hw registers. And people only implement fixup
in write, for example :-(.
								Pavel

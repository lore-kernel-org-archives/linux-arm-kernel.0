From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Mar 2012 01:51:36 +0100 (CET)
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-4-git-send-email-mturquette@linaro.org>
 <20120303133158.GA26882@pengutronix.de>
 <CAJOA=zNFNEHxBDhRDdvm7DYR83R0LJjsp_AT3BoG+nL+iN5_tw@mail.gmail.com>
 <20120304115201.GB26882@pengutronix.de>
 <CAJOA=zP8d8wm==7=svOzh03Ft-1_LV71q0mA6Pncrh5vQSWGEA@mail.gmail.com>
 <20120305073836.GU3852@pengutronix.de>
 <CAJOA=zMs75ZQ24g5PXpSLV3AJzWEo12g86G8+4+ryQR_cTYpzA@mail.gmail.com>
 <20120306190039.GJ3852@pengutronix.de>
 <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1203090148270.2742@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Mar 2012, Turquette, Mike wrote:
> Assuming that some day OMAP code can be refactored to allow for lazy
> (or at least initcall-based) registration of clocks then perhaps your
> suggestion can take root.  Which leads me to this question: are there
> any other platforms out there that require the level of expose to
> struct clk present in this patchset?  OMAP does, for now, but if that
> changes then I need to know if others require this as well.

I can't see the problem, really. Other than existing code doing stuff
before the memory allocator is up and running.

We allocate interrupt data structures in the early boot process today
and I don't see a reason why you want clocks, which have not been
configured by the boot loader, accesible before that point.

Thanks,

	tglx

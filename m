From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 04 Nov 2013 13:31:07 +0100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <2443024.JdDKnfkC18@wuerfel>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <25161583.XICaeMWvPh@flatron> <2443024.JdDKnfkC18@wuerfel>
Message-ID: <1563443.xGyilxtfIn@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 of November 2013 10:28:49 Arnd Bergmann wrote:
> On Monday 04 November 2013 00:26:29 Tomasz Figa wrote:
> > 
> > Aha, one more thing. As it was mentioned on ARM Mini Summit, as a long 
> > term goal, we will eventually have to introduce another validation tool 
> > that checks device drivers against device tree bindings. We should keep 
> > this in mind when considering schema design.
> 
> Incidentally I have just had an idea for a new driver-level API that
> should let us do this much easier. I hope to find some time in the
> next few days to come up with draft kernel patches. If you don't hear
> back from me soon but want to work on validating the drivers against
> the bindings, please contact me again.

I'd prefer to focus on the schema language itself and tools for DTS
validation. However the former needs driver validation to be considered
as well and that's why I mentioned it.

> 
> The basic idea is to extend 'devres' to automatically register
> all the resources (registers, irq, dma, gpio, pinctrl, clk, regulator, ...)
> and simple properties before the ->probe() callback is even called,
> based on a per-driver data structure that describes them, and that
> can be easily parsed by an external tool.

That would be nice and may even be helpful for solving the
dependency/deferred probe hell (or at least optimizing probe deferring).

Best regards,
Tomasz

From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 10 Sep 2012 12:16:24 +0100
Subject: [PATCH 08/14] tty/serial/kgdboc: Add and wire up clear_irqs
 callback
In-Reply-To: <20120910041357.GH29537@lizard>
References: <20120910040802.GA1261@lizard>
	<20120910041357.GH29537@lizard>
Message-ID: <20120910121624.226c1a88@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> serial port, the CPU receives NMI exception, and we fall into KDB shell.
> So, it is our "debug console", and it is able to interrupt (and thus
> debug) even IRQ handlers themselves.


You seem to have an assumption of single core here. What happens if the
NMI hits CPU #0 and the serial IRQ hits CPU #1 simultaneously ?

Alan

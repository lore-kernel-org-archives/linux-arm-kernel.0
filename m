From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 10 Sep 2012 12:11:05 +0100
Subject: [PATCH 10/14] tty/serial: Add kgdb_nmi driver
In-Reply-To: <20120910041412.GJ29537@lizard>
References: <20120910040802.GA1261@lizard>
	<20120910041412.GJ29537@lizard>
Message-ID: <20120910121105.724f982f@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Sep 2012 21:14:12 -0700
Anton Vorontsov <anton.vorontsov@linaro.org> wrote:

> This special driver makes it possible to temporary use NMI debugger port
> as a normal console by issuing 'nmi_console' command (assuming that the
> port is attached to KGDB).

No ref counting, no tty port, no compliance with the tty behaviour.
Concept looks fine but it needs porting to reflect a kernel newer than
about 2.6.18 8)

I would take a quick look at the tty_port helpers and also check v -next
which makes the tty_port mandatory. That'll pretty much cover your needs
for locking, semantics and the like.

Alan

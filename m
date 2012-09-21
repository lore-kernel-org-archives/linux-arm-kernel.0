From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 21 Sep 2012 16:14:02 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Message-ID: <20120921161402.25cf1520@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So I looked closer: uart_get_baud_rate() in turn calls out to
> tty_termios_baud_rate() which does some fuzzy matching to the
> fix baudrate table and simply "snaps" the baudrate to the closest
> match if it is "close enough".

The fuzzing is getting done when re-encoding and because the code
encodes/re-decodes stuff.

> I wonder how to fix this ... I'm planning to do what the comment
> in tty_ioctl says:

If you support the ancient alt speed hacks then its not quite so neat.

Alan

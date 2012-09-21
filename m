From: alan@linux.intel.com (Alan Cox)
Date: Fri, 21 Sep 2012 15:37:10 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
Message-ID: <20120921153710.220adb92@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Device drivers should use c_[io]speed directly!
> 
> Alan Cox wrote this, so Alan: should I just ditch the use of
> uart_get_baud_rate() and program the divider directly from
> c_[io]speed?

Yes.

The functions are designed to act as helpers for old devices. In fact
we can actually probably abolish tty_termios_baud_rate at this point as
I don't think there is much if anything left which blows up fed a non
Bxxx table entry.

I will have a look at that in fact see what it involves at this point.

Alan

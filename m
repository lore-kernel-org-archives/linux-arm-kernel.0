From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 9 May 2011 14:55:34 +0100
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <3A9C5CD56396439DBF825BB4E5779DB9@subhasishg>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<034A6447E0D54737B5CEE009A4D20B37@subhasishg>
	<20110509144610.6b4f7090@lxorguk.ukuu.org.uk>
	<3A9C5CD56396439DBF825BB4E5779DB9@subhasishg>
Message-ID: <20110509145534.2677dfa1@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 May 2011 19:20:17 +0530
"Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:

> >> I then modified this function to as follows and the error is not observed
> >> anymore.
> >
> > That looks like you are somehow calling uart_carrier_raised somewhere
> > with interrupts disabled ?
> >
> I am not calling this function in my driver atall, this is getting called by 
> tty_port.c

Can you verify the status of the interrupt flags at the point that
routine is called in your code and get a backtrace of the path. It
should never be gettng called with interrupts off, and if it is we need
to know what the path is. Otherwise that code change would imply a bug
in the core code for the platform which seems less likely.
 

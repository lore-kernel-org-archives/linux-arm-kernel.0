From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 21:20:08 +0100
Subject: [PATCH 02/14] ARM : SAMSUNG : Add RS485 support.
In-Reply-To: <CAC=G6syuf-J4am1mHRg-5gzqy661yOT9pUK2vQyToLPtv4tvEg@mail.gmail.com>
References: <1319255194-4799-1-git-send-email-paul.s.schilling@gmail.com>
	<20111022134726.GD21374@n2100.arm.linux.org.uk>
	<CAC=G6syuf-J4am1mHRg-5gzqy661yOT9pUK2vQyToLPtv4tvEg@mail.gmail.com>
Message-ID: <20111023202008.GB27802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 12:12:13PM -0500, Paul Schilling wrote:
> On Sat, Oct 22, 2011 at 8:47 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> + ? ? ? ? ? ? } else {
> >> + ? ? ? ? ? ? ? ? ? ? /* Set a short timer to toggle RTS */
> >> + ? ? ? ? ? ? ? ? ? ? mod_timer(
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &(ourport->rs485_tx_timer),
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? jiffies + usecs_to_jiffies(
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ourport->char_time_usec
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? / 10));
> >
> > This could do with being better formatted. ?Also, & doesn't need following
> > parens.
> 
> when I ran checkpatch it complained that it exceeded 80 characters.  I
> had trouble keeping this line
> under 80 characters.

		} else {
			mod_timer(&our_port->rs485_tx_timer, jiffies +
				  usecs_to_jiffies(ourport->char_time_usec
						   / 10));

is probably a better way to format it.

> >> - ? ? ? ? ? ? if (port->flags & UPF_CONS_FLOW)
> >> + ? ? ? ? ? ? if (port->flags & UPF_CONS_FLOW) {
> >> ? ? ? ? ? ? ? ? ? ? ? s3c24xx_serial_rx_enable(port);
> >> + ? ? ? ? ? ? }
> >
> > Why are you reformatting code?
> 
> I will remove the reformatting of the code.

If you wish to reformat the code to clean up checkpatch warnings, then that
needs to be a separate patch from any other changes.

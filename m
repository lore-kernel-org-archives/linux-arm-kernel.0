From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 9 May 2011 19:20:17 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <20110509144610.6b4f7090@lxorguk.ukuu.org.uk>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com><1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com><034A6447E0D54737B5CEE009A4D20B37@subhasishg>
	<20110509144610.6b4f7090@lxorguk.ukuu.org.uk>
Message-ID: <3A9C5CD56396439DBF825BB4E5779DB9@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I then modified this function to as follows and the error is not observed
>> anymore.
>
> That looks like you are somehow calling uart_carrier_raised somewhere
> with interrupts disabled ?
>
I am not calling this function in my driver atall, this is getting called by 
tty_port.c

int tty_port_block_til_ready(struct tty_port *port,
                                struct tty_struct *tty, struct file *filp)
{
 /* Probe the carrier. For devices with no carrier detect this
                   will always return true */
                cd = tty_port_carrier_raised(port);
                if (!(port->flags & ASYNC_CLOSING) &&
                                (do_clocal || cd))
                        break;
                if (signal_pending(current)) {
                        retval = -ERESTARTSYS;
                        break;
                }

 

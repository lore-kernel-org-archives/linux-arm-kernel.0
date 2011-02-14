From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 14 Feb 2011 18:45:17 +0530
Subject: [PATCH v2 09/13] can: pruss CAN driver.
In-Reply-To: <4D58F77B.9080005@pengutronix.de>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-10-git-send-email-subhasish@mistralsolutions.com>
	<20110211150602.GB373@e-circ.dyndns.org>
	<C1C4300CE90A406FBDA2388D5491FAD5@subhasishg>
	<4D58D854.5090503@grandegger.com>
	<1F33D30F9B2D47ECA80CEC807A6C0727@subhasishg>
	<4D58F77B.9080005@pengutronix.de>
Message-ID: <8CB9F2C8F75C4041B9F0691D209DDAFD@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The problem with the "all" implementation is that it hogs the ARM/DSP 
heavily and that's the reason why we specifically avoided this in our 
firmware design.
Hence, implementing this condition spoils the whole purpose of the PRU!!

--------------------------------------------------
From: "Marc Kleine-Budde" <mkl@pengutronix.de>
Sent: Monday, February 14, 2011 3:05 PM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: "Wolfgang Grandegger" <wg@grandegger.com>; "Kurt Van Dijck" 
<kurt.van.dijck@eia.be>; <davinci-linux-open-source@linux.davincidsp.com>; 
<linux-arm-kernel@lists.infradead.org>; <m-watkins@ti.com>; 
<nsekhar@ti.com>; <sachi@mistralsolutions.com>; "open list:CAN NETWORK 
DRIVERS" <socketcan-core@lists.berlios.de>; "open list:CAN NETWORK DRIVERS" 
<netdev@vger.kernel.org>; "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/13] can: pruss CAN driver.

Hello,

On 02/14/2011 09:45 AM, Subhasish Ghosh wrote:
> That is correct, we receive only pre-programmed CAN ids and "all" or
> "range" implementation is not there in the PRU firmware.

I'd really like to see that you add a "all" implementation to the
firmware. Or even better use the standard id/mask approach.

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   | 

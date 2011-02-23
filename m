From: davem@davemloft.net (David Miller)
Date: Wed, 23 Feb 2011 14:30:13 -0800 (PST)
Subject: [PATCHv2 2/2] DM9000B: Fix PHY power for network down/up
In-Reply-To: <4D642AC6.6050101@henry.nestler.mail.gmail.com>
References: <4D62D323.7010403@henry.nestler.mail.gmail.com>
	<20110222.102410.260079835.davem@davemloft.net>
	<4D642AC6.6050101@henry.nestler.mail.gmail.com>
Message-ID: <20110223.143013.246523171.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Henry Nestler <henry.nestler@gmail.com>
Date: Tue, 22 Feb 2011 22:29:42 +0100

> DM9000 revision B needs 1 ms delay after PHY power-on.
> PHY must be powered on by writing 0 into register DM9000_GPR before
> all other settings will change (see Davicom spec and example code).
> 
> Remember, that register DM9000_GPR was not changed by reset sequence.
> 
> Without this fix the FIFO is out of sync and sends wrong data after
> sequence of "ifconfig ethX down ; ifconfig ethX up".

I've applied both of your patches, thanks.

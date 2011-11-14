From: claudio@evidence.eu.com (Claudio Scordino)
Date: Mon, 14 Nov 2011 09:22:18 +0100
Subject: [PATCH] RS485: fix inconsistencies in the meaning of some
 variables
In-Reply-To: <20111113215318.GA2966@pengutronix.de>
References: <4E492CFF.7040905@pwrnet.de> <20110822211832.GA8023@kroah.com>
 <4EB3A009.10502@evidence.eu.com> <4EB8F6B9.6010008@atmel.com>
 <4EB90902.4030200@evidence.eu.com>
 <20111108134804.07095c5d@lxorguk.ukuu.org.uk>
 <20111108142432.GA11293@kroah.com> <4EBA9385.7010806@evidence.eu.com>
 <20111113215318.GA2966@pengutronix.de>
Message-ID: <4EC0CFBA.3090202@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 13/11/2011 22:53, Wolfram Sang ha scritto:
> Hi,
> 
> I have been working on a patch series which adds hardware RS485 to the 8250
> according to the latest developments. The series will be posted tomorrow after
> some more tests. However, there is one thing I wondered about:
> 
>>  From now on, SER_RS485_RTS_AFTER_SEND and SER_RS485_RTS_ON_SEND will be used to
>> set the voltage of the RTS pin (as in the crisv10.c driver); the delay will be
>> understood by looking only at the value of delay_rts_before_send and
>> delay_rts_after_send.
> 
> Do I overlook something or is SER_RS485_RTS_AFTER_SEND always the inverted
> signal of SER_RS485_RTS_ON_SEND. So why do we need both? (BTW
> SER_RS485_RTS_ON_SEND is a non-obvious name, I think. But changing it will
> probably break even more users?)

I think so, but I'm not sure since the original version of the Cris driver (prior than the
RS485 data structure) contained both values: a value for RTS during send and a value
for RTS after sent. That's why both vales have been reported inside the RS485 data structure...

Best regards,

	Claudio

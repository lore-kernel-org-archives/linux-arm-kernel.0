From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 30 Sep 2009 18:28:37 +0200
Subject: [RFC] AT91 cpufreq support
In-Reply-To: <4AC377CD.5020809@atmel.com>
References: <20090826193324.GB7084@pc-ras4041.res.insa>
	<4AC377CD.5020809@atmel.com>
Message-ID: <4AC38735.9020703@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre wrote :
> Anyway, as I see that there is a notifier for serial driver, I wonder if
> we can keep serial console connexion during frequency switching ? I
> assume that we will have to change the baud rate configuration of the
> terminal emulator but do you have a clue to give us (I tried without
> success) ?
> 
once called after the frequency change the notifier function in the 
serial driver updates uartclk and calls atmel_set_termios which should 
update the baudrate generator to the new master clock so you shouldn't 
need to change the baudrate.
To be clean, the serial port may need to be turned off before the 
frequency change in order to prevent garbage chars to be sent on the 
serial port as some USB serial adapters hang when receiving such garbage 
which may explain your problem.

Eric

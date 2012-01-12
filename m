From: rajanikanth.hv@stericsson.com (Rajanikanth H V)
Date: Thu, 12 Jan 2012 10:49:38 +0100
Subject: tty/serial: Need clarification on Support for 4+M Baudrate
In-Reply-To: <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
References: <20120111121901.GA4034@bnru05>
 <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
Message-ID: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan,

Thanks for your response, suggested modification helped to get 4.8M baud
but not 4.05M as this is being approximated to 4.0M baud which happens in
tty_termios_encode_baud_rate(...).

I have precise and weird requirement to get 4.05M baud as uart
baud clock divisor value changes between 4.0M and 4.05M Baud.

Any suggestion?

Thanks,
Rajanikanth

-----Original Message-----
From: Alan Cox [mailto:alan at lxorguk.ukuu.org.uk] 
Sent: Wednesday, January 11, 2012 6:00 PM
To: Rajanikanth H V
Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; gregkh at sude.de; linux-arm-kernel at lists.infradead.org
Subject: Re: tty/serial: Need clarification on Support for 4+M Baudrate

On Wed, 11 Jan 2012 17:49:01 +0530
> I have a requirement to interface UART with an external microcontroller 
> using baud rate above 4Mbps, hence following is my approach to apply
> the changes. Can any one review/provide me appropriate approach.

See TCGETS2/TCSETS2 and the BOTHER flag.

The kernel supports aetting arbitary baud rates already.

Alan

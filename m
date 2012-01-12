From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 12 Jan 2012 11:49:13 +0000
Subject: tty/serial: Need clarification on Support for 4+M Baudrate
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
References: <20120111121901.GA4034@bnru05>
 <20120111123025.244a9cf5@pyramind.ukuu.org.uk>
 <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20120112114913.21809bed@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jan 2012 10:49:38 +0100
Rajanikanth H V <rajanikanth.hv@stericsson.com> wrote:

> Alan,
> 
> Thanks for your response, suggested modification helped to get 4.8M baud
> but not 4.05M as this is being approximated to 4.0M baud which happens in
> tty_termios_encode_baud_rate(...).

Only if you don't have the BOTHER flag set and only for returned data to
user space.

When you do a TCSETS2 ioctl and have BOTHER set as the rate as well as a
c_ispeed/c_ospeed the exactly value is given to the driver.

Alan

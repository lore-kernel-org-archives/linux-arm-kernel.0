From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 May 2012 12:19:09 +0000
Subject: [PATCH RESEND v8] gpio: Device tree support for LPC32xx
In-Reply-To: <20120510234100.7F5463E04A6@localhost>
References: <1336679838-30738-1-git-send-email-stigge@antcom.de>
 <20120510234100.7F5463E04A6@localhost>
Message-ID: <201205111219.10025.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, Grant Likely wrote:
> How about the following instead (very rough, there should be a cleaner
> way to update the gc pointer in of_xlate):
> 
>         gpio: gpio at 40028000 {
>                 compatible = "nxp,lpc3220-gpio";
>                 reg = <0x40028000 0x1000>;
>                 gpio-controller;
>                 #gpio-cells = <3>; /* bank, pin, flags */
>         }
> 

I thought about that when I suggested the current binding to Roland,
but the problem with this is that passing the bank as a number is
not very intuitive when the data sheet has separate number spaces
for gpio, gpi and gpo here, so it seemed more natural to go with what
the data sheet describes.

	Arnd

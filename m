From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 13 Mar 2017 20:14:16 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <437d898d-b0f4-a4b5-cb51-8ea88ba7a35a@milecki.pl>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170312171032.GK15842@lunn.ch>
 <437d898d-b0f4-a4b5-cb51-8ea88ba7a35a@milecki.pl>
Message-ID: <20170313191416.GB10397@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 07:48:26PM +0100, Rafa?? Mi??ecki wrote:
> On 03/12/2017 06:10 PM, Andrew Lunn wrote:
> >>+	chosen {
> >>+		bootargs = "console=ttyS0,115200 earlycon";
> >
> >Using bootargs to pass the serial settings has been deprecated for a
> >while. Please use stdout-path instead.
> 
> I tried following patch with my SR400ac (I put Archer C5 aside for now).

Hi Rafael

Take a look at for example the bcm911360k.dts

        aliases {
                serial0 = &uart3;
        };

        chosen {
                stdout-path = "serial0:115200n8";
        };

You need an alias to the serial device you want to us, and you should
list the speed, parity, bits etc.

	Andrew

From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Oct 2012 07:46:32 +0100
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
In-Reply-To: <alpine.DEB.2.00.1210282123250.10589@marmot.wormnet.eu>
References: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
 <20121028205956.GH15143@lunn.ch>
 <alpine.DEB.2.00.1210282123250.10589@marmot.wormnet.eu>
Message-ID: <20121029064632.GJ15143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The chip markings are: SAMSUNG 146 K9F1G08U0D SCB0 (FKJ554PWN)
> 
> Unfortunately the other NAS is too far away to get at, but D-link
> haven't stuck to exactly the same chip. This DNS-320 review shows a
> different Samsung part:
> 
> http://diit.cz/data/images/thumb/67491_2b9e5e4fbd.jpg?1307884464
> 
> The datasheet for the K9F1G08U0D says max 35usecs "Data Transfer
> from Cell to Register", whereas K9F1G08U0C (what the DNS-320 review
> shows) says 25usecs. If this is the value in the datasheet to check,
> then this would explain the problems.

Seems sensible.

I'm currently downloading the GPL sources from dlink. If the kernel
sources are included, we can see how dlink sets this. If its also 35,
then there is no argument.

The only thing you could think about is probing the nand device, and
if it is not K9F1G08U0D put the delay back to 25.

   Andrew

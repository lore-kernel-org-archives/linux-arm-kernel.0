From: schen@mvista.com (Steve Chen)
Date: Thu, 21 Jan 2010 05:43:04 -0600
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <1b68c6791001201728ma5ce62dyb1d4825cedb8f9df@mail.gmail.com>
References: <20100119083803.GA17904@pengutronix.de>
	<4B561581.6060400@bluewatersys.com>
	<20100120005505.GD26562@trinity.fluff.org>
	<1263954112.3207.73.camel@linux-1lbu>
	<20100120023255.GV10014@trinity.fluff.org>
	<1263998346.3207.83.camel@linux-1lbu>
	<1b68c6791001201728ma5ce62dyb1d4825cedb8f9df@mail.gmail.com>
Message-ID: <1264074184.3207.109.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-21 at 10:28 +0900, jassi brar wrote:
> >
> > I'm also able to boot zImage under u-boot.  However, I had to set r1
> > manually, and I don't know how to pass kernel parameters (stuff passed
> > into kernel uImage via bootargs) to zImage.  Any tips will be greatly
> > appreciated.
> Perhaps you use 'go' instead of 'bootm' command in u-boot?
> How about:-
> 
>  u-boot # <load zImage@_addr_ by some means>
> 
>  u-boot # setenv machid <your machine ID in hex without the '0x'>
>  u-boot # saveenv //persistently save the machid
>              // now you don't need to set machid even after cold reset
> 
>  u-boot # bootm _addr_
> 
> hth.

Yes, I did use go instead of bootm.  I'll give this a try.  I'm using
u-boot version 1.3.3.  Based on Uwe's comment, there is a good chance
that I'll need to upgrade my u-boot.  Thank you all for the feedback.

Steve

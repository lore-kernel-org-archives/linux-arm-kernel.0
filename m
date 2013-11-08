From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Nov 2013 10:09:28 +0100
Subject: [patch 1/1] ARM: kirkwood: stop printk TCLK value at boot for DT
 boards
In-Reply-To: <527CA812.9050003@gmail.com>
References: <20131105180931.674625171@rtp-net.org> <527CA812.9050003@gmail.com>
Message-ID: <20131108090928.GF4440@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Kirkwood: MV88F6281-A0, TCLK=0
> >
> >This patch modifies the message for printing only the kirkwood id,
> >as it allows to detect if we're running A0/A1/... variants with a simple
> >dmesg.
> 
> Arnaud,
> 
> for DT based booting we also have the "Machine" printed right above the
> "Kirkwood" string. Don't you think, that we can remove the pr_info
> completely?

Hi Sebastian

I think it is useful, as a debug tool. What is printed here is probed
from the hardware. We know it is correct. The Machine string is from
DT and somebody could be trying to boot with the wrong DT blob.

   Andrew

From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 9 Jul 2011 07:26:53 +0530
Subject: PL330 alignment requirement questions
In-Reply-To: <2034464824.379455.1310162217325.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <1866031594.379248.1310161913147.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<2034464824.379455.1310162217325.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <CABb+yY2aMSsA6+R+1RhExoAUTz4OcHB8ucuyR8OK9Ahe=0XVCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2011 at 3:26 AM,  <johnlinn@comcast.net> wrote:
> I'm testing our PL330 with the driver/dma/pl330 driver and see some strangeness that's probably my own setup issue.
>
> I'm also using drivers/dmatest to test it with memory to memory copies. I'm seeing that the copy alignment (copy_align) is not setup (it's 0) such that I see errors on some transfers at the end of the transfer.
>
> If I setup the copy_align to be 3 or larger then I don't see these errors. This number doesn't make much sense to me and I'm digging into the details (seems like 4 would make sense). ?I just wanted to see if anyone had tested with dmatest and seen anything similar.
>
It might help if you dump length, src_addr and dst_addr of failed transfers.
drivers/dma/pl330.c was not rigorously tested because Samsung drivers
use their own DMA API.
Btw, please remember to CC the author.

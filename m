From: quozl@laptop.org (James Cameron)
Date: Fri, 6 Dec 2013 13:55:41 +1100
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131206003851.GI16425@us.netrek.org>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <20131206003851.GI16425@us.netrek.org>
Message-ID: <20131206025541.GL16425@us.netrek.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 11:38:51AM +1100, James Cameron wrote:
> On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> > pxa2xx-uart was a separate uart platform driver. It was declaring
> > the same device names and numbers as 8250 driver. As a result,
> > it was impossible to use 8250 driver on PXA SoCs.
> > 
> > Upon closer examination pxa2xx-uart turned out to be a clone of
> > 8250_core driver.
> 
> I'm testing this backported to 3.5 on the OLPC XO-4 [1] [2].
> 
> As Russell says, the getty had to change, but after that the shell
> worked fine; no more or no less responsive.
> 
> What hasn't worked yet is the console; no kernel messages appear.  I
> have tried changing command line to console=ttyS0,115200.

My error.  Our kernel had CONFIG_CMDLINE set, changing that fixed it.
Console is working fine.

-- 
James Cameron
http://quozl.linux.org.au/

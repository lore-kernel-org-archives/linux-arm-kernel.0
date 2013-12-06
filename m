From: quozl@laptop.org (James Cameron)
Date: Fri, 6 Dec 2013 11:38:51 +1100
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
Message-ID: <20131206003851.GI16425@us.netrek.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.

I'm testing this backported to 3.5 on the OLPC XO-4 [1] [2].

As Russell says, the getty had to change, but after that the shell
worked fine; no more or no less responsive.

What hasn't worked yet is the console; no kernel messages appear.  I
have tried changing command line to console=ttyS0,115200.

1.  http://dev.laptop.org/~quozl/y/1VojGn.txt (diff relative to
olpc-kernel/arm-3.5)

2.  http://dev.laptop.org/~quozl/z/1VojLz.txt (dmesg)

-- 
James Cameron
http://quozl.linux.org.au/

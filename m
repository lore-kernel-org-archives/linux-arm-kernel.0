From: alan@linux.intel.com (Alan Cox)
Date: Thu, 24 Jun 2010 14:34:26 +0100
Subject: Regression in next-20100618
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025FD0D69A@EXDCVYMBSTM006.EQ1STM.local>
References: <CEE6BB42CAD6E947908279175AF8470A025FD0D69A@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20100624143426.083f49e9@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jun 2010 14:17:51 +0200
Linus WALLEIJ <linus.walleij@stericsson.com> wrote:

> Looping in linux-arm-kernel in case there are more people having
> this regression on -next since 20100618.
> 
> I verified that the regression also appears on U300, and I
> suspect all platforms using PL011 to suffer from it, including
> Versatile, RealView and SPEAr for example.
> 
> Symptom: garbage characters at TTY prompt after boot.
> 
> Trying to figure out what is causing this but failing :-/

I know what the problem is - I've just not yet had time to fix it (or a
stable electricity supply this afternoon).

The serial layer doesn't cope with the fact the tty_port code manages
the active flag so needs to switch to its own - and clear it in
->shutdown/set it in open

Alan

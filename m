From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Oct 2014 07:51:04 +0100
Subject: net: fec: fix regression on i.MX28 introduced by rx_copybreak
 support
In-Reply-To: <20141029.153430.1036004676442879956.davem@davemloft.net>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
 <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
 <20141029.153430.1036004676442879956.davem@davemloft.net>
Message-ID: <20141030075104.05e44b43@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

David Miller wrote:
> From: Lothar Wa?mann <LW@KARO-electronics.de>
> Date: Tue, 28 Oct 2014 14:22:55 +0100
> 
> > Changes wrt. v1:
> > - added some cleanup patches
> > - simplify handling of 'quirks' flags as suggested by Russell King.
> > - remove DIV_ROUND_UP() from byte swapping loop as suggested by
> >   Eric Dumazet
> > 
> > Changes wrt. v2:
> > - rebased against next-20141028
> > - added some more cleanups in fec.h
> > - removed unused return value from swap_buffer()
> > - fixed messed swab32s() call in swap_buffer2()
> > - fixed messed up setup of fep->quirks
> > 
> 
> It is not appropriate to mix cleanups and bonafide bug fixes.
> 
> I want to see only bug fixes targetted at 'net'.  You can later
> submit the cleanups to 'net-next'.
> 
OK.

> Also, I don't thnk your DIV_ROUND_UP() eliminate for the loop
> in swap_buffer() is valid.  The whole point is that the current
> code handles buffers which have a length which is not a multiple
> of 4 properly, after your change it will no longer do so.
>
Do you really think so?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

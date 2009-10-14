From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 14 Oct 2009 13:02:35 +1300
Subject: ts72xx: rc4 doesn't boot anymore
In-Reply-To: <4AD5121D.4070309@techworks.ie>
References: <4AD5121D.4070309@techworks.ie>
Message-ID: <4AD5151B.30300@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> Hi all,
> 
> I really don't understand what's happenning, nothing has changed on my
> side (same board, same bootloader), rc2 was booting OK, rc3 didn't boot
> unless I pass on the command line the config for half of my memory
> (mem=8M at 0x0 mem=8M at 16M mem=8M at 64M mem=8M at 80M). Now with rc4 it's even
> worth, the kernel complains about bad configuration page, detects 16MB
> of memory and ignore any mem= command line params (this board has 8
> nodes of 8MB each).
> 
> Below is the trace of the crash, I've added some debug printk,
> especially concerning the atags (attached is my hack of
> arch/arm/kernel/setup.c and another patch i need to get the board
> booting (I know it's bad))
> 
> Unless I'm missing something, the rc2 was booting OK, I'm sure.
> 
> Any help greatly appreciate.
> 

Can you do a bisect between rc4 and rc2 (or rc3 with the command line
arguments you gave) to see if you can track down a specific commit which
is breaking your setup.

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

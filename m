From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Jan 2014 14:42:36 +0100
Subject: NAND support for Armada 370
In-Reply-To: <20140102124407.GF10251@enneenne.com>
References: <20140102124407.GF10251@enneenne.com>
Message-ID: <20140102144236.270c4a6a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rodolfo Giometti,

The e-mail address you used for Gregory is wrong. Also, for NAND
questions, you should Cc Ezequiel Garcia (I added him), as he is our
NAND driver developer.

On Thu, 2 Jan 2014 13:44:07 +0100, Rodolfo Giometti wrote:

> I'm working on vanilla kernel 3.13-rc6 and an Armada-370 based board
> (compatible with armada-370-db) and I'm trying to get NAND support
> working.
> 
> I noticed that on my kernel is missing your patch named "[PATCH v2
> 01/27] clk: mvebu: Add Core Divider clock", however after applying it
> I get:
> 
>    pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
>    pxa3xx-nand f10d0000.nand: Wait time out!!!
>    pxa3xx-nand f10d0000.nand: Wait time out!!!
>    pxa3xx-nand f10d0000.nand: Wait time out!!!
>    No NAND device found
> 
> Do I still miss something? And what about DMA support?

The 3.13-rc kernels do not have NAND support for Armada 370/XP. The
NAND support will only arrive in 3.14. You can try the linux-next tree,
but I'm not sure it has absolutely all of the patches that are needed
(I see at least one potentially missing).

Alternatively, you can use the backport-3.10 branch at
https://github.com/MISL-EBU-System-SW/mainline-public/commits/backport-3.10.
It is based on 3.10, and has a good number of backported patches,
including NAND support.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

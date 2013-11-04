From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Nov 2013 09:41:38 -0300
Subject: [PATCH v2 11/27] mtd: nand: pxa3xx: Disable OOB on arbitrary
 length commands
In-Reply-To: <20131103225903.GE5896@gmail.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131103225903.GE5896@gmail.com>
Message-ID: <20131104124137.GF2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 03, 2013 at 05:59:05PM -0500, Huang Shijie wrote:
> On Fri, Oct 18, 2013 at 08:02:38PM -0300, Ezequiel Garcia wrote:
> > READID, STATUS and PARAM (aka ONFI read paramater page) don't read
> > the OOB area. Set the oob_size to zero and prevent it.
> The ERASE, RESET also donot need to read the OOB,
>    why not zero the oob_size for these commands?
> 

Because this only matters for commands that will use the oob_size field
when doing some I/O operation. Both ERASE and RESET commands have no data
cycle, so it makes no sense to haev a non-zero oob_size field.

On the other side, this patch is rather stupid, as oob_size is already
cleared at the beggining of a command sequence. So, I'll either rework
this or drop it entirely.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

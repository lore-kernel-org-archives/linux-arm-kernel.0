From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 11 Oct 2009 16:41:46 +0300
Subject: [PATCH] mtd: maps/sa1100: fix section mismatch
In-Reply-To: <1255076329-15065-1-git-send-email-mad_soft@inbox.ru>
References: <1255076329-15065-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1255268506.16942.77.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-09 at 12:18 +0400, Dmitry Artamonow wrote:
> Commit f0b1e589 changed sa1100_mtd_probe from __init to __devinit,
> but missed to correct sa1100_setup_mtd definition accordingly, which
> causes following warning:
> 
> WARNING: vmlinux.o(.devinit.text+0xf4): Section mismatch in reference from
>  the function sa1100_mtd_probe() to the function .init.text:sa1100_setup_mtd()
> The function __devinit sa1100_mtd_probe() references
> a function __init sa1100_setup_mtd().
> If sa1100_setup_mtd is only used by sa1100_mtd_probe then
> annotate sa1100_setup_mtd with a matching annotation.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Added to my l2-mtd-2.6.git tree:

http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/232216ec8d423a222ae113bd15691d66a1e6d957

-- 
Best Regards,
Artem Bityutskiy (????? ????????)

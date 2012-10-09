From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 12:08:54 +0000
Subject: [PATCH 01/16] ARM: warnings in arch/arm/include/asm/uaccess.h
In-Reply-To: <50726966.5010503@snapgear.com>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
 <1349448930-23976-2-git-send-email-arnd@arndb.de>
 <50726966.5010503@snapgear.com>
Message-ID: <201210091208.55090.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 October 2012, Greg Ungerer wrote:
> On 06/10/12 00:55, Arnd Bergmann wrote:
> > On NOMMU ARM, the __addr_ok() and __range_ok() macros do not evaluate
> > their arguments, which may lead to harmless build warnings in some
> > code where the variables are not used otherwise. Adding a cast to void
> > gets rid of the warning and does not make any semantic changes.
> >
> > Without this patch, building at91x40_defconfig results in:
> >
> > fs/read_write.c: In function 'rw_copy_check_uvector':
> > fs/read_write.c:684:9: warning: unused variable 'buf' [-Wunused-variable]
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Ungerer <gerg@uclinux.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Greg Ungerer <gerg@uclinux.org>

Thanks!

> I can pick it up and push to the arm-soc tree.

Well, my idea was that I would prefer the patches go through some other tree
besides arm-soc since they are not really the main purpose for this tree.

The core ARM patches in particular should go through Russell's ARM tree.
I have a few more that come in during the merge window and plan to send
him a pull request for those.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jul 2016 11:49:52 +0200
Subject: [PATCH 0/7] net: ethernet: bgmac: Add platform device support
In-Reply-To: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <7754885.zcSf8DnDt9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2016 6:59:07 PM CEST Jon Mason wrote:
> Well, no compilained too loudly at the RFC version of this patch series
> (see https://lkml.org/lkml/2016/6/28/863).  So, I'm officially sending
> this out for inclusion.  All comments from the RFC were addressed in
> this version.
> 
> This patch series adds support for other, non-bcma iProc SoC's to the
> bgmac driver.  This series only adds NSP support, but we are interested
> in adding support for the Cygnus and NS2 families (with more possible
> down the road).
> 
> To support non-bcma enabled SoCs, we need to add the standard device
> tree "platform device" support.  Unfortunately, this driver is very
> tighly coupled with the bcma bus and much unwinding is needed.  I tried
> to break this up into a number of patches to make it more obvious what
> was being done to add platform device support.  I was able to verify
> that the bcma code still works using a 53012K board (NS SoC), and that
> the platform code works using a 58625K board (NSP SoC).

Looks reasonable overall. I have one comment for the binding, but
we can handle them separately. I think the first five patches
can just get merged through net-next if there are no other concerns,
and feel free to add my

Acked-by: Arnd Bergmann <arnd@arndb.de>


For the last two patches, once we have worked out the right
compatible strings, please send them to Florian for merging through
the arm-soc next/dt branch.

	Arnd

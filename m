From: davidb@quicinc.com (David Brown)
Date: Wed, 30 Sep 2009 09:35:33 -0700
Subject: Empty ATAG_CORE support.
Message-ID: <20090930163533.GA26833@huya.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to
<http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html>

The ATAG_CORE tag can have a size of either 5 or 2.  The code in
arch/arm/kernel/setup.c seems to handle either case fine.  However,
the __vet_atags function in arch/arm/kernel/head-common.S only
allows the size to be 5.

Currently, the Android bootloader uses an ATAG_CORE with a size
of 2, causing all of the atags to be ignored.  Internally, we
have just removed the size check entirely.  Before I submit a
patch for this, however, I wanted to make sure I implement the
correct behavior.  Should it be restricted to 2 or 5 only, or are
larger sizes allowed?

Thanks,
David Brown

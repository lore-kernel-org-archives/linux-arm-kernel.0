From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 12 Apr 2011 15:04:48 +0200
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
Message-ID: <BANLkTi=jV12tOR_=idn0z+oO_RQ2xaFhCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/12 Rafa? Mi?ecki <zajec5@gmail.com>:
> Cc: Michael B?sch <mb@bu3sch.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: George Kashperko <george@znau.edu.ua>
> Cc: Arend van Spriel <arend@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Botting <andy@andybotting.com>
> Cc: linuxdriverproject <devel@linuxdriverproject.org>
> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> V2: Rename to axi
> ? ?Use DEFINE_PCI_DEVICE_TABLE in bridge
> ? ?Make use of pr_fmt and pr_*
> ? ?Store core class
> ? ?Rename bridge to not b43 specific
> ? ?Replace magic 0x1000 with BCMAI_CORE_SIZE
> ? ?Remove some old "ssb" names and defines
> ? ?Move BCMAI_ADDR_BASE def
> ? ?Add drvdata field
> V3: Fix reloading (kfree issue)
> ? ?Add 14e4:0x4331
> ? ?Fix non-initialized struct issue
> ? ?Drop useless inline functions wrappers for pci core drv
> ? ?Proper pr_* usage
> V3.1: Include forgotten changes (pr_* and include related)
> ? ?Explain why we dare to implement empty release function

There is one more change I started to consider. Is "core" correct name
for AXI's device? Almost everywhere we can read about *components* on
the AXI interconnect.

Maybe it'd make sense to s/core/comp/? Arend?

-- 
Rafa?

From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 18 Aug 2015 11:21:52 +0200
Subject: [PATCH] rtc: armada38x: Align RTC set time procedure with the
 official errata
In-Reply-To: <1438874328-31844-1-git-send-email-gregory.clement@free-electrons.com>
References: <1438874328-31844-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150818092152.GV22269@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 at 17:18:48 +0200, Gregory CLEMENT wrote :
> From: Nadav Haklai <nadavh@marvell.com>
> 
> According to the Armada38x functional errata FE-3124064, writing to
> the RTC TIME register may fail. As a workaround, after writing to RTC
> TIME register, issue a dummy write of 0x0 twice to the RTC Status
> register.  This is the updated implementation of the Errata that
> eliminates the need of the long 100ms delay during the RTC set time
> procedure.
> 
> [gregory.clement at free-electrons.com]: removed the mutex and use the
> spinlock again
> 
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Sat, 10 Sep 2016 00:23:16 +0200
Subject: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
In-Reply-To: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
Message-ID: <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you look more carefully the first problem is actually a bus error:
[ 15.776190] Unhandled fault: external abort on non-linefetch (0x1028)
at 0xf9e3e044
[ 15.825925] PC is at omap_hwmod_read+0x14/0x28
[ 15.830583] LR is at omap_rtc_wait_not_busy+0x1c/0x44

I have no idea how the kernel manages to continue after a bus error in
a driver (inside local_irq_disable even), but I wouldn't be inclined
to take any later errors seriously.

See also the "4.8 crash on BeagleBone" thread on linux-omap.

Matthijs

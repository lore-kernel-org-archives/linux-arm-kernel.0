From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Sep 2016 16:47:43 -0700
Subject: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
In-Reply-To: <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
 <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
Message-ID: <20160909234742.becrs3zb4ihc2mq6@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [160909 15:23]:
> If you look more carefully the first problem is actually a bus error:
> [ 15.776190] Unhandled fault: external abort on non-linefetch (0x1028)
> at 0xf9e3e044
> [ 15.825925] PC is at omap_hwmod_read+0x14/0x28
> [ 15.830583] LR is at omap_rtc_wait_not_busy+0x1c/0x44
> 
> I have no idea how the kernel manages to continue after a bus error in
> a driver (inside local_irq_disable even), but I wouldn't be inclined
> to take any later errors seriously.
> 
> See also the "4.8 crash on BeagleBone" thread on linux-omap.

Yeah. Just disable omap_l3_smx/noc driver and you should see
a proper stack trace. With the L3 driver we're seeing the trace
for L3 error interrupt.

Regards,

Tony

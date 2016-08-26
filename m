From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Aug 2016 13:14:01 +0200
Subject: [PATCH v2] arm64: dts: rockchip: fix the address map for WDT0 and
 WDT1
In-Reply-To: <1472208482-30862-1-git-send-email-zhengxing@rock-chips.com>
References: <1472208482-30862-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <17136512.4k6A6uo3GV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 26. August 2016, 18:48:01 schrieb Xing Zheng:
> To rename "watchdog" to "watchdog0" explicitly for looking up.
> Dues to incorrect description in the TRM, the WDTs base address
> should be fixed and swap them like this:
> WDT0 - 0xff848000
> WDT1 - 0xff840000
> 
> And, it is right that only WDT0 can generate global software reset.
> We will update the TRM to fix it.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

I had applied v1 already, so I have now just amended it with the watchdog0
change [0]. In any case the fix is in my dts64 branch for 4.9 now.


Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=8859d81a562e484f06712fadb8886d78ed0be851

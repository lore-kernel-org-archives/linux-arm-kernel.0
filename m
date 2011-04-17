From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 17 Apr 2011 15:40:21 +0800
Subject: [PATCH] ARM: fix badly implementation of wmb
In-Reply-To: <BANLkTikByisrp7wDnRK+hFcD-Vcy8eYYvA@mail.gmail.com>
References: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
	<BANLkTikByisrp7wDnRK+hFcD-Vcy8eYYvA@mail.gmail.com>
Message-ID: <BANLkTimD=H=K5pmR9guWzfABSpqBE=63Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

2011/4/17 Catalin Marinas <catalin.marinas@arm.com>:
> 3. Because Normal non-cacheable memory acceses are buffered at the L2
> cache level, we need to drain its buffer in the mb()/wmb() case, hence
> the outer_sync() call.

If you confirmed dsb plus outer_sync are needed for this case, the patch
is surely pointless. In fact, I thought dmb is enough for this case,
so introduce
the patch.  Now you have clarified it, please drop it.

>
> If you find alternatives to the points above I may agree with your patch.
>
> Please note that there have been several discussions on LKML around
> barriers for I/O vs Normal memory and the consensus was *not* to
> introduce additional barrier types since device drivers don't use them
> anyway.
>
> Can you show many situations where you would need mandatory barriers
> but not in relation to I/O?

No, thank you for the explanation, sorry for the noise.

thanks,
-- 
Ming Lei

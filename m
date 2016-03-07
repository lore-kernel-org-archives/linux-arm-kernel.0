From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 07 Mar 2016 10:12:55 +0100
Subject: 4.4.3: OOPS when running "stress-ng --sock 5"
In-Reply-To: <87twkmd6or.fsf@gmail.com> (Holger Schurig's message of "Fri, 04
 Mar 2016 08:48:52 +0100")
References: <87twkmd6or.fsf@gmail.com>
Message-ID: <87fuw2d52g.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I compared my config with imx_v6_v7_defconfig which didn't segfault.

After I turned on CONFIG_SWAP, my segfault vanished.

I did turn off CONFIG_SWAP because my device only has SD-Card and eMMC.
So I never intended to create a swap partition. And thought "why compile
it in the kernel when I never use it?".

But it seems the kernel is instable with this setting.

So we have a potential denial-of-service in kernels compiled without
CONFIG_SWAP, don't we? At least when it comes to skb handling.

Other memory tests never showed anything weird, and my system is running
X11 with some Qt applications as well as Java applications since about a
year without trouble. During all this time without CONFIG_SWAP.

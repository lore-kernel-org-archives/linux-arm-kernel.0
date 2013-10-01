From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 01 Oct 2013 17:39:15 +0100
Subject: [PATCH] ARM: vexpress: ignore MIDR[0] for uart detection
In-Reply-To: <CAC_HJnzfvi59i0e0-VwhUtKPxiPLU9o+Y6Dvts9HVkKC6gyqRw@mail.gmail.com>
References: <1380449869-19911-1-git-send-email-yrehan@gmail.com>
 <CAC_HJnzfvi59i0e0-VwhUtKPxiPLU9o+Y6Dvts9HVkKC6gyqRw@mail.gmail.com>
Message-ID: <1380645555.30015.8.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-10-01 at 09:11 +0100, Mian Yousaf Kaukab wrote:
> Can you please take a look at this patch? Default vexpress_defconfig
> does not boot on qemu vexpress-a9 target without it.

Right, I think I've heard about it...

To be honest, I have rather mixed feelings about it. In particular I
could say that if qemu returns r0p0, it doesn't model V2P-CA9, which has
A9 r0p1 :-) Also, the DEBUG_LL and EARLY_PRINTK are pretty low level
features and it seems that they simply shouldn't be enabled in the
defconfig. As I'll be updating defconfig soon, I'll make sure they're
disabled.

Yes, I agree that the "detection" code is a hack. I'm not sure we have
to make it even hackier. Let me have a think about it, as I can't really
spend any time of the matter this week, sorry.

Thanks for your efforts!

Pawel

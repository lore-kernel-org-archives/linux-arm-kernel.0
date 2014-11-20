From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 20 Nov 2014 20:46:59 +0100
Subject: Bad page state when running Linux on CSB637
Message-ID: <20141120194659.GE4545@sisyphus.hd.free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

as I already mentioned on the list (but could not find the mail to
reply to it), I get "BUG: Bad page state" messages when running
Linux on a CSB637 board (using an AT91RM9200). I have reproduced the
issue with the stock 3.18.0-rc4.

Some more details about what I could find out:
- I observed different behaviours with exactly the same kernel
configuration, but the network driver compiled as module instead of
being built-in, or when booting with an initramfs vs booting using
NFS;
- the same configuration (whether network driver is compiled as a
module or built-in, initramfs vs NFS) consistently has or does not
have the message during execution of the init scripts;
- even if I do not observe the message during the execution of the
init scripts, I may have it later when using the board (I mean, when
it is not idle);
- I am using a version of u-boot which is a snapshot from 2009, so,
u-boot doing something wrong or that it should no longer do, or that
was later fixed before the next release, is not out of the question;
- when I first noticed this problem and did a bisection, I arrived
at at a commit concerning the use of memblock on ARM, though I could
not confirm that it really was culprit of anything by checking out
the previous and next commits. If the bug depends on the memory
layout of the system, changing revision changes the memory layout
and even the config variables so generate different results, and the
chain of decisions of the bisection simply does not mean anything.

Could you tell me what quantitative information I could give you to
help me fix this issue ?

Thanks in advance.
Regards.

-- 
					    Gilles.

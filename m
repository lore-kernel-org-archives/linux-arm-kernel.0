From: GNUtoo@no-log.org (Denis 'GNUtoo' Carikli)
Date: Sat, 22 Jan 2011 19:07:06 +0100
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <alpine.LFD.2.00.1101221802280.31804@localhost6.localdomain6>
References: <1295576730.4096.24.camel@Joe-Laptop>
	<1295624801.19880.13.camel@m0nster>
	<20110121094827.41818a55@jbarnes-desktop>
	<20110121095658.1ab623fe@jbarnes-desktop>
	<1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<AANLkTikVDn+W8t7KSym5tCGZowyYvoLFrk8d0mumiRF-@mail.gmail.com>
	<20110121234930.GK3043@thunk.org> <1295684398.19231.47.camel@jaguar>
	<AANLkTinEnNYjhA2WRD=1AqmHYY3ec0uJxRVmLW57_EU=@mail.gmail.com>
	<AANLkTikrDxtkVFJ0C-SwH9QCq4m0A2KMp0vAFA=PaSGM@mail.gmail.com>
	<alpine.LFD.2.00.1101221802280.31804@localhost6.localdomain6>
Message-ID: <1295719626.2827.18.camel@gnutoo-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-01-22 at 18:28 +0100, Thomas Gleixner wrote:
> I really appreciate the well structured effort which Daniel is putting
> into this. 
Me too.


I've an issue similar to the problem mentioned in this thread:
I own a board which came,by default with a 2.6.27 kernel.
A developer of the company that produced and sell the board ported the
board to the 2.6.30 kernel during his spare time(if I remember well)
The patch is publicly available in their svn tree in the form of a
standard unified diff patch(not a git patch)

Is that the proper format for the commit message:
    mx31: add support for the bugbase 1.3 from buglabs
    
    This work was based on bug-linux-2.6.30.patch that can be found
      in buglabs's svn here:
      svn://bugcamp.net/bug/branches/izzy/experimental
    
    Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>

The work I did was porting forward the board initialization code and the
serial port support from 2.6.30 to linux-next.
I debugged(with md in uboot to get the printk buffer) the fact that the
serial didn't work,and removed unneeded code to make it work.

I've not submitted yet the work because of this thread,
thanks to Russell King's response I think I'll submit it.


Here's another commit I made and that went into mainline:
commit 9df86e2e702c6d5547aced7f241addd2d698bb11
Author: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Date:   Fri Aug 27 23:48:19 2010 +0200

wl1251: Fix queue stopping/waking for TX path

This patch was adapted from 06f7bc7db79fabe6b2ec16eff0f59e4acc21eb72
(from linus's linux-2.6 tree of kernel.org)

here's the original message:
    The queue stopping/waking functionality was broken in a way that
could
    cause huge latencies in TX transfers and even cause the TX to stall
in the
    right circumstances. Correct these problems.
    
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Acked-by: Kalle Valo <kvalo@adurom.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

In this commit I was told not to put the original sign-off, authors
etc...
This is because it would have been confusing and misleading:
It would have appeared like if the commit got Ack,Sign-off etc... by the
people involved in the original commit.

Denis.

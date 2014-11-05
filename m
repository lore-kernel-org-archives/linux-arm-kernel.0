From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 4 Nov 2014 20:15:06 -0500
Subject: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
In-Reply-To: <20141104210315.GF24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
Message-ID: <20141105011506.GG24112@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 04:03:15PM -0500, Lennart Sorensen wrote:
> So it seems to be working on our board so far.  Will stress test it
> some more.  No DMA of course for now, but oh well.

Well 4 hours running with multiple reboots (our testsuite reboots every
30 minutes to test the watchdog).  So far it has only lost 70 bytes out
of 40MB of data sent between uart7 and uart8 (and we are pretty sure
the serial test has a small bug that causes a few bytes to be lost right
after a reboot sometimes).

The reason I am even trying the new driver today is that we were seeing
soft lockups on the CPU whenever the serial ports were being tested,
usually in less than 5 minutes, so 4 hours without a lockup is a good
sign.  No idea what might be wrong with the old omap serial driver, but
it seems something is (unless of course we managed to break it somehow
when we tried to solve its habit of dropping characters).

I think I will stick with this new driver.  Better long term future
anyhow.

-- 
Len Sorensen

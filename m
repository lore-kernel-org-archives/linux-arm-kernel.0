From: khilman@ti.com (Kevin Hilman)
Date: Fri, 11 Feb 2011 15:01:21 -0800
Subject: [PATCH v5 0/5] omap: mailbox: hwmod support
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Wed, 2 Feb 2011 13:27:18 -0600")
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <87ipwq89by.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> Mailbox hwmod support for OMAP 2,3,4.
>
> This was tested on OMAP3 (3430, 3630), minor testing
> was made on OMAP4.
>
> No testing on OMAP2 since I don't have the hardware.

To help in testing, I wrote a simple mailbox loopback test module for
OMAP2/3/4 that I used to do send and receive messages on the MPU.  This
can be used to test the mailbox without any DSP software.

I tested it against l-o master branch and found a couple bugs in the
mailbox driver (patches posted earlier today.)  

With those patches plus my test I can send & receieve a series of
messages on the MPU, which is enough to sanity test the basic sending
and receiving messages on the MPU.

I've tested the master branch, now it's your turn to use this test
module to validate this hmod conversion series.

The test module is available here:

    git://gitorious.org/omap-test/mailbox.git

Note that the current mailbox driver has hard-coded settings for the
receiver of messages.  While this should be configurable at runtime, I'm
not an expert on the mailbox IP so my test module includes a kernel
patch that changes these hard-coded settings of the first mbox (dsp on
OMAP2/3, mailbox-1 on OMAP4) so that my loopback tester will work.

Kevin

From: davidb@codeaurora.org (David Brown)
Date: Thu, 16 Dec 2010 16:16:58 -0800
Subject: [PATCH 1/7] msm: io: I/O register definitions for MSM8960
In-Reply-To: <201012152337.19475.arnd@arndb.de>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<201012151740.24933.arnd@arndb.de>
	<20101215220317.GA22394@huya.qualcomm.com>
	<201012152337.19475.arnd@arndb.de>
Message-ID: <20101217001658.GA5880@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 11:37:19PM +0100, Arnd Bergmann wrote:

> Yes, I understand that it's hard for many reasons, but my impression
> is that there is a general agreement on the idea. As I said, I don't
> expect you to fix it all at once, but it shouldn't be too hard
> to take care when adding new code.
> 
> We already have infrastructure that deals with different CPU cores
> in one kernel binary, at least from v5 to v7, and some platforms
> like omap and realview can already be built for a variety of very
> different machines without such problems.

I agree with this goal, and I think I have a plan to get us there.

For example, the iomap constants.  To fix this, this data needs to be
moved into platform data, or something similar.  It seems to me to
make the most sense to move the individual devices out of the iomap
until at least the devices used so far on 8960 are all done
dynamically.  Then at least these constants aren't needed for this
target.

There are similar things that need to be done for irqs, and timer
offsets.

I'm not sure really what to do about PHYS_OFFSET.  This is kind of the
big thing that has kept us so far from making our SOCs multiply
selectable.  I could move this into a Kconfig option, but it would
still need to be selected by the SOC.  It is unfortunate that most of
our SOCs have different enough memory configurations that these are
mostly different.  Even 8960/8660 will probably have future variants
that are at different addresses.

My question, then is, should we hold off on getting 8960 support into
the kernel until enough things are improved to get rid of the 8960
ifdefs?  We can certainly do it that way, but it will keep the code
out of the kernel longer.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

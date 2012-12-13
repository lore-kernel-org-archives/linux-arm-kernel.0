From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Dec 2012 14:20:41 +0100
Subject: dma: mv_xor: error handling fixes
Message-ID: <1355404843-4587-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gr?gory,

Here are two patches fixing error handling code in the mv_xor
initialization code. When the initialization of one particular XOR
channel fails, we have some cleanup code that isn't correct, and
triggers a kernel warning (fixed by the first patch) and then a kernel
crash (fixed by the second patch).

The original bug has been introduced in the big XOR series pushed for
3.8, so ideally, those patches should be pushed for 3.8 as well (but
they can wait after 3.8-rc1 if needed).

If you want a formal pull request, please let me know, but I guess for
two patches, it is just as easy for you to apply it to some of your
branch.

Thanks!

Thomas

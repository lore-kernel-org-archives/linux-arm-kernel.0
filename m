From: eric@anholt.net (Eric Anholt)
Date: Mon, 27 Apr 2015 16:14:06 -0700
Subject: [PATCH 0/3] Raspberry Pi firmware driver
Message-ID: <1430176449-12322-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is mostly a squash/rename of my previous property and power
domain drivers, on top of the new non-channels mailbox driver I sent
earlier.  I definitely like how much less boilerplate there is.

I've switched the power domains to just using the property request,
which has an obvious mapping to the on/off hooks we need to implement
(the firmware tracks which domains are currently requested by the
user).

The code can also be found at: https://github.com/anholt/linux/tree/rpi-mailbox

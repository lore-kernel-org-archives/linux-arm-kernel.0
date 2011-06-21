From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 21 Jun 2011 01:09:11 -0400
Subject: [PATCH 0/4] allow DTB to be appended to the ARM zImage with ATAG
	conversion
Message-ID: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yet another resend, this time with a patch to convert some ATAGs and
fold them into the appended DTB.  Additional ATAgs and their corresponding
DTB representation is still up for discussion.  In particular,
ATAG_REVISION and ATAG_SERIAL were mentioned as missing but there is
no direct DT equivalent for them.  One suggestion was to fold them into
the kernel cmdline string.  Anything else?

Testing would also be appreciated.

[PATCH 1/4] ARM: zImage: ensure it is always a multiple of 64 bits in size
[PATCH 2/4] ARM: zImage: Allow the appending of a device tree binary
[PATCH 3/4] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
[PATCH 4/4] ARM: zImage: allow supplementing appended DTB with traditional ATAG data

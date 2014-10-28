From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 28 Oct 2014 23:04:50 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141027223114.GU2560@atomide.com>
References: <20141019090107.GA19132@amd> <201410262222.39892@pali>
 <20141026215548.GA9004@amd> <201410262323.17891@pali>
 <20141027195209.GP2560@atomide.com>
 <20141027223114.GU2560@atomide.com>
Message-ID: <20141028220450.GA27667@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Here's a patch that should fix the issues for built-in USB
> gadgets.
> 
> Pavel, care to see if this gets NFSroot over USB working again
> for you?

It seems to have did the trick for me. (Plus I needed to add

+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
+# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set

to be able to control the command line, that's why testing took me a
while.)

Networking now works against 3.17-based kernel. Thanks!

Tested-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

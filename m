From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 16 Feb 2016 21:15:57 +0100
Subject: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
In-Reply-To: <1455637767-31561-16-git-send-email-james.morse@arm.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
Message-ID: <20160216201557.GA6526@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-02-16 15:49:27, James Morse wrote:
> Resuming using a different kernel version is fragile, while there are
> sufficient details in the hibernate arch-header to perform the restore,
> changes in the boot process can have a long-lasting impact on the system.
> In particular, if the EFI stub causes more memory to be allocated, the
> amount of memory left for linux is reduced. If we are lucky, this will
> cause restore to fail with the message:

Well, this does not close the door completely. 4.6-rc0 is going to be
very different from 4.6-rc1. Better solution would be to increase
version every time EFI stub changes, or maybe record ammount of memory
reserved for EFI.

Best regards,
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

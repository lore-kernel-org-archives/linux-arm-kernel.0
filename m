From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Apr 2014 15:48:16 +0100
Subject: [PATCH 5/5] arm: Enable IRQs before attempting to read user
 space in __und_usr
In-Reply-To: <CAKZGPAP=9wvUd-oSEYKwBz6LKX6vXcRuiRVUpg2k47ui-=YgQw@mail.gmail.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
 <1394734552-4704-6-git-send-email-catalin.marinas@arm.com>
 <CAKZGPAP=9wvUd-oSEYKwBz6LKX6vXcRuiRVUpg2k47ui-=YgQw@mail.gmail.com>
Message-ID: <20140401144815.GA7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 05:54:15PM +0530, Arun KS wrote:
> As the data abort is now handled in normal way, can we remove the
> fixup handler for ldrt?

No, because all instructions which access userspace, and therefore may
fault, must be given a fixup handler so the kernel knows what to do
should it not be able to supply the page.

Omitting that marking means the only other option in that case is for
the kernel to oops.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

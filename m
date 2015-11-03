From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 11:14:37 +0000
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy
 loading
In-Reply-To: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20151103111437.GU8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 04:10:08PM +0800, Caesar Wang wrote:
> As the Russell said:
> "in other words, which can be handled by updating a control register in
> the firmware or boot loader"
> Maybe the better solution is in firmware.

The full quote is:

"I think we're at the point where we start insisting that workarounds
which are simple enable/disable feature bit operations (in other words,
which can be handled by updating a control register in the firmware or
boot loader) must be done that way, and we are not going to add such
workarounds to the kernel anymore."

The position hasn't changed.  Workarounds such as this should be handled
in the firmware/boot loader before control is passed to the kernel.

The reason is very simple: if the C compiler can generate code which
triggers the bug, it can generate code which triggers the bug in the
boot loader.  So, the only place such workarounds can be done is before
any C code gets executed.  Putting such workarounds in the kernel is
completely inappropriate.

Sorry, I'm not going to accept this workaround into the kernel.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

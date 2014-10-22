From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 22 Oct 2014 15:55:18 +0200
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022135518.GO9845@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 10:34:40AM -0300, Ezequiel Garcia wrote:
> This series adds support for the 25 MHz reference clock available on
> Armada 375 SoC to use on the timer and watchdog drivers. It is
> similar to the one present in Armada XP SoC.
> 
> Given we initially had access to only a very early SoC revision (A375 Z0)
> and due to a hardware issue, the timer and watchdog support was originally
> submitted to use the core clock.

Hi Ezequiel

What happens with Z0 when used with these patches? Do they continue to
work? Do these hardware issues cause a problem?

> Now that the A0 SoC revision is out, we can fix this and use the reference
> clock. The reason for this change is that the core clock is subject to the
> SSCG, so boards where SSCG is enabled exhibit a very large timer drift.

It would of been nice to say what SSCG is. I had to go look it up.
However, since this is just in the cover note and not in the patches
itself, it is not important.

	Andrew

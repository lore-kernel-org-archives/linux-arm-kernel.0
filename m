From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Oct 2017 10:45:17 +0100
Subject: [PATCH] ARM: compressed: discard ksym/kcrctab input section
In-Reply-To: <874lr4d8gm.fsf@free-electrons.com>
References: <20170908153143.27279-1-ard.biesheuvel@linaro.org>
 <87d163kt0m.fsf@free-electrons.com>
 <CAKv+Gu_pGeDxK_vD9iGUO486VgLsntMQwVs9wGKa79pkx7paMQ@mail.gmail.com>
 <20171004124320.GP20805@n2100.armlinux.org.uk>
 <CAKv+Gu_t+oLJKGzy3LxgLZqqYsd9eQiwZRr6dgPbqpsHnQUUxw@mail.gmail.com>
 <874lr4d8gm.fsf@free-electrons.com>
Message-ID: <20171012094517.GB20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 11:24:57AM +0200, Gregory CLEMENT wrote:
> Hi Ard,
> 
> Can we move forward to fix the booting problem ?
> 
> What about amending your commit log with this new information and then
> submit it to Russell patch system?

Well, I think there's a choice that needs to be made between this
approach and Arnd's approach.

I'm not all that thrilled with the need to add explicit alignment to
data that is inherently a byte stream, and that invariably results in
unaligned data words even if you do align the start of it.  That
sounds to me very much like a hack rather than a proper solution.
So, right now I'm leaning more towards Arnd's solution than Ard's
from what's been said in this thread.

However, I don't recall Arnd's patch, it's probably buried deep in
my mailbox.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

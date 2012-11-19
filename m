From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Nov 2012 14:44:17 +0000
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
Message-ID: <20121119144417.GH3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 07:57:10PM +0530, Naresh Bhat wrote:
> I can see the below question on dmesg "No ATAGs ?"
> ...........
> ...............
> CPU1: Unknown IPI message 0x1
> Brought up 2 CPUs
> SMP: Total of 2 processors activated (3981.31 BogoMIPS).
> NET: Registered protocol family 16
> No ATAGs?

That is the procfs initialization of ATAGs producing that message.  If
you're not booting with ATAGs but instead using DT, then you will get
this message, and it's harmless... in which case kexec should be passing
the DT blob to the next kernel.

If it isn't, then its a kexec bug.

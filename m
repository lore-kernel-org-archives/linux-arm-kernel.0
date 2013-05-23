From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 08:53:04 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <20130522233108.01cb51f0@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <201305222240.05124.arnd@arndb.de> <20130522233108.01cb51f0@skate>
Message-ID: <20130523075304.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 11:31:08PM +0200, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> The thing that I believe you don't realize is that those new bootloaders
> are already shipping *today*. And they are not putting whatever
> "correct" information into the DT you believe they should be putting.

Well, if they're not putting addresses of registers into the DT, then
that DT information is surely pretty much useless to the kernel - or
anything.

If it's putting _wrong_ addresses in the DT, then the same thing applies.

Either way, it says "you need to change the DT blob passed to the kernel."

Luckily, as has already been agreed, DT blobs will not be hard-coded into
boot loaders, so that's easily sorted - you just tell people in the
installation instructions "if you have X versions of the boot loader, you
need to use DT blob X, otherwise you need to use blob Y."

>From what you're saying, that's the best that can be done - the kernel
can't do much else.

I'd also hasten to point out that even if we could detect the base of the
registers, with DT, what matters is what's in the DT blob itself, which
should override any detection.  So the DT blob would need to be updated
in any case.

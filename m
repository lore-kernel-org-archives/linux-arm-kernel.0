From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 10:20:09 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <20150220094035.GE8656@n2100.arm.linux.org.uk>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
Message-ID: <20150220102009.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 09:40:35AM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 20, 2015 at 09:24:39AM +0000, Ard Biesheuvel wrote:
> > Yes, this looks like a GCC problem, not binutils, since there are
> > other .S files in the same folder that contain crypto instructions
> > that build fine. This particular one is a .c file with AES
> > instructions in inline asm() (and we pass -march=armv8-a+crypto)
> 
> Maybe we need to get jk's blog post updated - it's currently on of
> the top hits in google, so this is probably going to trip up a lot of
> people if they follow the instructions there.
> 
> http://jk.ozlabs.org/docs/arm64-toolchain/
> 
> So it sounds like possibly the binutils part of those instructions is
> fine, it's the gcc part which isn't.

Note that it would also be useful to know where to get a working gcc
from (preferably in source form - I doubt there's any Fedora 14
binaries around.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

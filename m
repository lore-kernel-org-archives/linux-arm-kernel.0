From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Wed, 15 Apr 2015 14:44:54 -0400
Subject: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
In-Reply-To: <552E9714.10001@ti.com>
References: <1425427237-11511-2-git-send-email-nm@ti.com>
 <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
 <20150310153321.GO5264@atomide.com> <54FF28F5.4040707@ti.com>
 <20150310173115.GS5264@atomide.com> <54FF38F3.2030703@ti.com>
 <CACRpkdZ1faucps07jaT9kOyviC+Sw6gPkbF=cAGCUj+DiaEgTA@mail.gmail.com>
 <20150318014151.GL31346@atomide.com>
 <20150415012910.GA29560@csclub.uwaterloo.ca>
 <552E9714.10001@ti.com>
Message-ID: <20150415184454.GT29558@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 15, 2015 at 11:51:32AM -0500, Nishanth Menon wrote:
> I am yet to post a new revision to this series - few other stuff got
> in the way. IODelay driver in no way removes the constraint that the
> SoC architecture has - most of the pins still need to be muxed in
> bootloader - we cannot escape that. The reasoning for doing the mux in
> bootloader is independent of the need for iodelay.
> 
> Reasoning for mux in bootloader is because the mux and pull fields are
> glitchy - much more than previous generations of TI SoCs and
> significantly long enough to cause issues depending on the pins being
> muxed.

Well if we know glitching is NOT an issue on our boards, then we don't
have to do anything in the boot loader other than the basic setup for
the serial console and emmc and SD, which has always been necesary.

I consider moving the mux setup to the bootloader a terrible design and
won't go along with it.  We make sure all external devices have reset
lines being held while the pinmux is being setup, so glitching is a
non issue.

> Reasoning for iodelay is different - it is a hardware block meant to
> control the timing of signals in a particular signal path to ensure
> that specification compliance is met.
> 
> Lets try not to mix the two.

Well I was told by multiple people from TI that the reason for moving
the pinmux setup to the bootloader was because of the iodelay issue,
so you will have to get the message made clear within TI then.

-- 
Len Sorensen

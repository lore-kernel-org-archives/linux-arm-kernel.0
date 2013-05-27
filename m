From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 May 2013 12:04:53 +0200
Subject: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c
 driver
In-Reply-To: <51A25C21.2060700@schinagl.nl>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <51A1E9AA.4000008@schinagl.nl> <20130526132120.GJ17847@lukather>
 <51A25C21.2060700@schinagl.nl>
Message-ID: <20130527100453.GM17847@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

On Sun, May 26, 2013 at 09:01:53PM +0200, Oliver Schinagl wrote:
> On 05/26/13 15:21, Maxime Ripard wrote:
> >For the iowrite* vs write*, there's no consensus, and as such no
> >preferred way. write* functions are doing an MMIO only access,
> >while iowrite functions can do MMIO and port I/O accesses.
> >
> >Note that it doesn't change anything on ARM, since there's no port IO on
> >ARM.
> Ah I see, missinformation on my end. Sorry.
> 
> But why write 32 bits? The register is only 8 wide, with the rest
> being 'reserved'. Then again, the register IS 32 bits wide and
> probably will haev 32 bits written to it? Correct?

Yes, the register is 32 bits wide. However, and I didn't noticed it at
first, that all the registers have the 3 upper bytes reserved.

But you'll end up writing a 32 bits value to a 32 bit register register
anyway, even if the relevant information is contained in the 8 first
bits.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

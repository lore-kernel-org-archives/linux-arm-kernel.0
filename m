From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jan 2014 22:17:08 +0000
Subject: imx6 wand board lockdep warnings on boot
In-Reply-To: <CAOesGMiP2nzrACVr4xy5NTfKFOEwkyGdCU2_ZFYRNhv8B_ncPA@mail.gmail.com>
References: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
 <CAOesGMiP2nzrACVr4xy5NTfKFOEwkyGdCU2_ZFYRNhv8B_ncPA@mail.gmail.com>
Message-ID: <20140129221708.GV15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 01:58:51PM -0800, Olof Johansson wrote:
> On Wed, Jan 29, 2014 at 1:52 PM, Kevin Hilman <khilman@linaro.org> wrote:
> > For awhile now, the wand boards have had some noisy lockdep warnings
> > during boot, but I'm not sure if anyone is looking into them.  I see
> > it on the wand-solo and wand-quad, but not the dual.  Full boot logs
> > for all three are attached from v3.13.
> 
> Yeah, this one is known -- Russell has mentioned it in the past too.
> 
> This reminds me, I've been meaning to turn on lockdep on all defconfig
> builds so that we get coverage on more platforms, but I haven't done
> it yet.

It's really worth considering that - as well as building the defconfigs -
that the defconfigs are built with the kernel debugging options forced on
so that things like locking problems are found.  Obviously, debug info is
one option you wouldn't want to turn on, because for a build+boot test
system, it just makes the objects unnecessarily larger and wastes disk
space (unless of course you intend to use the debug info.)

I've just modified all my oldconfig builds to have many of the debug
stuff enabled.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

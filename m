From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 15:17:32 +0100
Subject: [PATCH 08/14] ASoC: kirkwood: prefer external clock over
 internal clock
In-Reply-To: <20130902110105.GN3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk> <20130901184153.353c644f@armhf>
 <20130902110105.GN3084@sirena.org.uk>
Message-ID: <20130902141732.GW6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 12:01:05PM +0100, Mark Brown wrote:
> On Sun, Sep 01, 2013 at 06:41:53PM +0200, Jean-Francois Moine wrote:
> > Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > > +	} else if (rate == 44100 || rate == 48000 || rate == 96000) {
> 
> > The rate is always good, and having this test raises a compilation warning
> > (clks_ctrl may be not initialized).
> 
> That should be fixed - it might be worth keeping the test and adding an
> else with an error return for robustness.

I believe you already have a fix merged.  I don't have that fix in my tree.

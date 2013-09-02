From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 12:01:05 +0100
Subject: [PATCH 08/14] ASoC: kirkwood: prefer external clock over
 internal clock
In-Reply-To: <20130901184153.353c644f@armhf>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
 <20130901184153.353c644f@armhf>
Message-ID: <20130902110105.GN3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 06:41:53PM +0200, Jean-Francois Moine wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> > +	} else if (rate == 44100 || rate == 48000 || rate == 96000) {

> The rate is always good, and having this test raises a compilation warning
> (clks_ctrl may be not initialized).

That should be fixed - it might be worth keeping the test and adding an
else with an error return for robustness.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/1e9ebb66/attachment-0001.sig>

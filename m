From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Apr 2014 23:57:21 +0100
Subject: [PATCH RFC 5/5] ahci_imx: add disable for spread-spectrum
In-Reply-To: <CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
 <E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk>
 <CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com>
Message-ID: <20140416225721.GP24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 05:46:47PM -0500, Rob Herring wrote:
> On Wed, Apr 16, 2014 at 3:43 AM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Spread-spectrum doesn't work with Cubox-i hardware, so we have to
> > disable this feature.  Add a DT property so that platforms can
> > indicate that this feature should not be enabled.
> 
> This is for spread-spectrum tx or rx? Transmit SS is optional to
> support, but the receiver must support SS. Otherwise random drives
> won't work which makes for a good user experience. Is this really a
> board quirk rather than a Si issue?

No idea.  This bit controls clock generation, and one reason given to
disable it is if the reference clock being supplied is already spread
spectrum.  I don't think that applies here.  It doesn't say which
clock(s) this is applied to - I would guess it's the transmit clock.

All I know is that with SS enabled, the drive is not detected, and
SolidRun's original port disables SS.  Disabling SS allows the external
drive to be detected.

I have no capability to check the eye pattern, so I've no idea if
there's a problem with the electrical setup which stops SS from
working.  All I know is with the parameters I give here (which are
those which SolidRun's original port uses) and with SS disabled,
it works.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

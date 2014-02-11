From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Feb 2014 12:33:56 +0000
Subject: [PATCH 0/7] primecell: make correct clock parsing possible
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140211123356.GH26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 11:37:05AM +0000, Mark Rutland wrote:
> These patches attempt to harmonize the bindings and the drivers with what's in
> use today, in a backwards compatible fashion, relieving us of our present
> Kafkaesque nightmare. Each peripheral's clock(s) are given explicit names which
> can be used, though code will fall back to the existing behaviour if said names
> are not provided. Additionally the currently unmet ordering requirement of
> apb_pclk is dropped, given all existing that code requires this to be named
> anyway.

The reason why these clocks ended up with NULL names was to force the
issue that clocks shall not be named solely by their connection IDs,
which was a major problem before DT.  Now that we have DT, I'm happier
to reinstate the names, but I think we should just reinstate the names
we had previously.  That should be in the git history.

The down-side is those names are all in capitals - but they were named
after the signal name(s) given in the Primecell documentation.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

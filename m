From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Sep 2017 12:29:37 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920224522.GB20974@obsidianresearch.com>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
Message-ID: <20170921112937.GV20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 04:45:22PM -0600, Jason Gunthorpe wrote:
> +		if (!fail || fail == -ENODEV)
> +			timespec64_add_ns(&next, 659 * NSEC_PER_SEC);
> +		else
> +			/* Update failed, try again in about 10 seconds */
> +			timespec64_add_ns(&next, 10 * NSEC_PER_SEC);

Trying to build this, the compiler complains about integer overflow here.
You need to cast these to 64-bit values.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

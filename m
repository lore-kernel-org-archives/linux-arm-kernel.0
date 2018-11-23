From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Nov 2018 10:50:34 +0000
Subject: Sleeping in user_access section
In-Reply-To: <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
Message-ID: <20181123105034.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 01:57:12AM -0800, hpa at zytor.com wrote:
> You should never call a sleeping function from a user_access section.
> It is intended for very limited regions.

So, what happens if the "unsafe" user access causes a page fault that
ends up sleeping?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

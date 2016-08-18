From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2016 15:53:00 +0100
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160818145300.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 01:45:52PM +0100, Vladimir Murzin wrote:
> This patch set allows M-class cpus benefit of optional cache support.
> It originally was written by Jonny, I've been keeping it locally mainly
> rebasing over Linux versions.
> 
> The original idea behind patches was to reuse existing cache handling
> code from v7A/R with help of extra macros to factor out cache handling
> logic (v7M cache operations are provided via memory mapped interface
> rather than co-processor instructions).
> However, that idea was rejected and starting form this (v2) version
> V7M cache logic lives into file and macros to indirect memory-mapped
> operations stay there locally since they make it easier to follow the
> code.
> 
> Along with the v7M cache support the first user (Cortex-M7) is
> introduced.
> 
> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
> one showed significant boot speed-up.

>From a quick read through, the approach looks sane, and I think I'm
now happy with these.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

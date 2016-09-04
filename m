From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Sep 2016 23:09:03 +0100
Subject: [PATCH] ARM: LPAE: initialize cachepolicy correctly
In-Reply-To: <20160904053331.7264-1-stefan@agner.ch>
References: <20160904053331.7264-1-stefan@agner.ch>
Message-ID: <20160904220903.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 03, 2016 at 10:33:31PM -0700, Stefan Agner wrote:
> The cachepolicy variable gets initialized using a masked pmd
> So far, the pmd has been masked with flags valid for the 2-page
> table format. In the LPAE case, this lead to a wrong assumption
> of what the initial cachepolicy has been used. Later a check
> forces the cache policy to writealloc and prints the following
> warning:
> Forcing write-allocate cache policy for SMP
> 
> This patch uses PMD_SECT_WBWA to mask all cache setting flags.
> The define represents the complete mask of the cache relevant
> flags for both page table formats.

PMD_SECT_WBWA is just one possible combination, it's not a bit-mask.
We need a new definition.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

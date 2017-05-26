From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 May 2017 23:39:21 +0100
Subject: [PATCH 1/4] ARM: ep93xx: switch to SPARSEMEM
In-Reply-To: <c5d6d870-48f8-f6c4-1ec9-6b540d0dca98@gmail.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-2-hsweeten@visionengravers.com>
 <440efa53-dbbf-5600-3441-87c6891c5389@gmail.com>
 <c5d6d870-48f8-f6c4-1ec9-6b540d0dca98@gmail.com>
Message-ID: <20170526223920.GM22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 09:13:36AM -0700, Florian Fainelli wrote:
> OK this is weird, this patch applied against v4.11 works fine on a 32MB
> board configuration, but applied against v4.12-rc2 I now get the following:
> 
> Uncompressing Linux... done, booting the kernel.
> Warning: Neither atags nor dtb found
> 
> as if r2 was lost somehow.
> 
> I will start a bisection to figure out if/when it started to break.
> Russell do you have an idea?

I've seen it on other platforms where the dtb is placed too close to
the kernel image, so when the decompressor relocates itself, it ends
up overwriting the dtb.

Remember that the bigger the decompressed kernel image, the higher
the decompressor relocates itself in memory.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

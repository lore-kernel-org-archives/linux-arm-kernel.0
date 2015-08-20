From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Aug 2015 14:00:06 +0100
Subject: [PATCH] ARM: Set proper TEXT_OFFSET for IPQ806x
In-Reply-To: <20150820121541.GA14664@codeaurora.org>
References: <20150820121541.GA14664@codeaurora.org>
Message-ID: <20150820130005.GS7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 05:45:41PM +0530, Varadarajan Narayanan wrote:
> RAM starts at 0x40000000 for IPQ. The lower 21MB of RAM is used
> for Shared Memory and the kernel can start from 0x41500000.

Why do people keep creating crap like this?  Each time something like
this is created, it means that you _need_ to have a special kernel for
your platform and you can't be part of the single zImage.

Please, rather than creating crap like this, find a better way.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

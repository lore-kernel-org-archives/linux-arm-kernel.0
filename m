From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Sep 2011 20:05:27 +0100
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <4E706BA2.5060804@ti.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<4E706BA2.5060804@ti.com>
Message-ID: <20110914190526.GD6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 02:23:54PM +0530, Santosh wrote:
> As mentioned earlier, you need to save only once since non of the L2
> configuration values will change. So 'save ones' and 'restore always
> when context lost' should be the right way to go about it.

Might as well arrange for the save to be at initialization time -
there's no point saving the configuration at every suspend.

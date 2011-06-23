From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jun 2011 14:37:02 +0100
Subject: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
Message-ID: <20110623133702.GZ23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 11:26:27AM +0200, Per Forlin wrote:
> Here are the results.

It looks like this patch is either a no-op or slightly worse.  As
people have been telling me that dsb is rather expensive, and this
patch results in less dsbs, I'm finding these results hard to believe.
It seems to be saying that dsb is an effective no-op on your platform.

So either people are wrong about dsb being expensive, the patch is
wrong, or there's something wrong with these results/test method.

You do have an error in the ported patch, as that hasn't updated the
v7 cache cleaning code to remove the dsb() there, but that would only
affect the write tests.

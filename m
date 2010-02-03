From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 10:10:47 +0000
Subject: [PATCH 10/16] ARM: LPC32XX: Converted most register types to
	void __iomem *
In-Reply-To: <1265155168-28909-11-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-11-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203101047.GC22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 03:59:22PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> Most defined registers addresses used for readl/writel were untyped.
> These have been changed to (void __iomem *).

Just arrange for io_p2v() to return a void __iomem pointer instead of
adding all these casts.  Virtual addresses should where-ever possible
be pointer like rather than integer like.

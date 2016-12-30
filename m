From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 19:57:23 +0800
Subject: [PATCH 2/2] ARM: imx: Add speed grading check for imx6ul
In-Reply-To: <1480475098-2037-2-git-send-email-ping.bai@nxp.com>
References: <1480475098-2037-1-git-send-email-ping.bai@nxp.com>
 <1480475098-2037-2-git-send-email-ping.bai@nxp.com>
Message-ID: <20161230115717.GR6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:04:58AM +0800, Bai Ping wrote:
> On i.MX6UL, it has two type of part, the difference
> is the max ARM frequency that can run at(528MHz/700MHz).
> The part can be identified by part marking for speed grading
> fuse. This patch add speed grading check to disable the unsupported
> OPP dynamically.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

We chose to handle such speed grading thing in IMX platform code with
the assumption that this is a special case for i.MX6Q only.  No, I'm not
going to take such code for any other i.MX6 SoCs.  Please patch cpufreq
driver to handle the speed grading check.

Shawn

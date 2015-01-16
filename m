From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 16 Jan 2015 10:20:14 +0100
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150116092014.GA27945@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,


On Fri, Jan 16, 2015 at 10:05:51AM +0100, Alexandre Belloni wrote:
> There is no point in calling suspend/resume for unused
> clockevents as they are already stopped and disabled.
> 
> Furthermore, it can take some time to wait for some IPs to stop counting.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Reported-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Indeed, this is way better from what I did.


> +		if (dev->suspend && dev->mode != CLOCK_EVT_MODE_UNUSED)

I wonder if we should use > CLOCK_EVT_MODE_SHUTDOWN
(or CLOCK_EVT_MODE_UNUSED || CLOCK_EVT_MODE_SHUTDOWN) instead of 
!CLOCK_EVT_MODE_UNUSED.


Sylvain

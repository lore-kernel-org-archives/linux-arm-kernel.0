From: johnstul@us.ibm.com (john stultz)
Date: Wed, 17 Nov 2010 16:27:08 -0800
Subject: [PATCH] ARM: tegra: timer: Separate clocksource and sched_clock
In-Reply-To: <1290039615-23407-1-git-send-email-ccross@android.com>
References: <1290039615-23407-1-git-send-email-ccross@android.com>
Message-ID: <1290040028.2504.24.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 16:20 -0800, Colin Cross wrote:
> tegra_clocksource_read should not use cnt32_to_63, wrapping is
> already handled in the clocksource code.  Move the cnt32_to_63
> into the sched_clock function, and replace the use of clocksource
> mult and shift with a multiplication by 1000 to convert us to ns.
> 
> Change-Id: Ica1158c3fbed0ba53391f7db61180129a957511d
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: John Stultz <johnstul@us.ibm.com>

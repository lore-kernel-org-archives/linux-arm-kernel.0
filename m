From: davidb@codeaurora.org (David Brown)
Date: Thu, 10 Nov 2011 10:33:21 -0800
Subject: [PATCH 0/8] MSM timer fixes and cleanups
In-Reply-To: <1320777250-23263-1-git-send-email-sboyd@codeaurora.org>
References: <1320777250-23263-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20111110183321.GA16832@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 10:34:02AM -0800, Stephen Boyd wrote:
> Currently the MSM timers use the same physical counter
> for the clockevent and clocksource. This works as long
> as the clocksource isn't stopped from ticking during normal
> operation but unfortunately that isn't the case and the
> clocksource is stopped when the clockevent is shutdown.
> Even worse, switching the clocksource via sysfs at runtime will
> hang the system.
> 
> This series reorganizes the MSM timer code so that one counter
> is only used for either a clocksource or a clockevent, and not 
> both. In the process we reduce the lines of code and fix
> a few long-standing bugs.

How do you test these on the upstream kernel?  Booting successfully is
probably a good starting point, though.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

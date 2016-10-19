From: briannorris@chromium.org (Brian Norris)
Date: Tue, 18 Oct 2016 18:36:13 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <20161019012441.GW8871@codeaurora.org>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com> <20160919231441.GA60928@google.com>
 <57E0E97B.5000106@arm.com> <20160928012309.GA29518@localhost>
 <20160929170847.1227a312@arm.com> <20161004174903.GA3098@localhost>
 <20161019012441.GW8871@codeaurora.org>
Message-ID: <20161019013612.GA107490@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 06:24:41PM -0700, Stephen Boyd wrote:
> Just curious, do we enter this state during cpuidle as well? Or
> is it only across suspend that the clock stops working?

I believe we do not on either rk3288 or rk3399. We'd have to be powering
off almost the entire system before we'd be able to gate the 24 MHz
oscillator, AIUI.

Brian

From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 18 Feb 2014 13:11:11 -0600
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140218191111.GH31116@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:26:06PM +0100, Thomas Petazzoni wrote:
> Dates after January, 19th 2038 are badly handled by userspace due to
> the time being stored on 32 bits. This causes issues on some Marvell
> platform on which the RTC is initialized by default to a date that's
> beyond 2038, causing a really weird behavior of the RTC.
> 
> In order to avoid that, reset the date to a sane value if the RTC is
> beyond 2038.

Just so I better understand: is this really a problem that is unique to
this particular RTC?  It smells a bit like we're papering over a problem
that may exist for other RTCs as well, and if so, is better solved in
the core.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

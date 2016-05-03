From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 3 May 2016 07:12:04 -0500
Subject: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
In-Reply-To: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
Message-ID: <57289594.3050801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush Anand wrote:
> + * Note: This watchdog timer has two stages. If action is 0, first stage is
> + * determined by directly programming WCV and second by WOR. When first
> + * timeout is reached, WS0 is triggered and WCV is reloaded with value in
> + * WOR. WS0 interrupt will be ignored, then the second watch period starts;
> + * when second timeout is reached, then WS1 is triggered, system resets. WCV
> + * and WOR are programmed in such a way that total time corresponding to
> + * WCV+WOR becomes equivalent to user programmed "timeout".
> + * If action is 1, then we expect to call panic() at user programmed
> + * "timeout". Therefore, we program both first and second stage using WCV
> + * only.

So I'm not sure I understand how this works yet, but there was an 
earlier version of Fu's driver that did something similar.  It depended 
on being able to reprogram the hardware during the WS0 interrupt, and 
that was rejected by the community.

How is what you are doing different?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

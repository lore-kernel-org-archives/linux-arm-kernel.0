From: davidb@codeaurora.org (David Brown)
Date: Tue, 1 Oct 2013 13:01:21 -0700
Subject: [PATCH] clocksource: put nodes passed to CLOCKSOURCE_OF_DECLARE
 callbacks centrally
In-Reply-To: <1380618053-11159-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380618053-11159-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131001200121.GA18640@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:00:53AM +0200, Uwe Kleine-K?nig wrote:
>Instead of letting each driver call of_node_put do it centrally in the
>loop that also calls the CLOCKSOURCE_OF_DECLARE callbacks. This is less
>prone to error and also moves getting and putting the references into the
>same function.
>
>Consequently all respective of_node_put calls in drivers are removed.
>
>Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>---
> arch/arm/mach-msm/timer.c             | 1 -

Acked-by: David Brown <davidb@codeaurora.org>


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

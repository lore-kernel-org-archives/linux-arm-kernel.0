From: davidb@codeaurora.org (David Brown)
Date: Wed, 24 Jul 2013 13:30:26 -0700
Subject: [PATCH 3/4] msm_serial: Make baud_code detection more dynamic
In-Reply-To: <1374691051-28544-4-git-send-email-sboyd@codeaurora.org>
References: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
 <1374691051-28544-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130724203026.GD10926@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:37:30AM -0700, Stephen Boyd wrote:
>Currently msm_set_baud_rate() assumes the uart clock rate is
>1.8432 MHz. This is not always true, and limits our options to
>program the baud rate. Instead of assuming the rate and
>hard-coding the baud_code based on it, calculate the divider that
>we want and try to find the closest baud_code that matches. This
>allows us to support uarts with faster clock speeds.
>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> drivers/tty/serial/msm_serial.c | 98 ++++++++++++++++++-----------------------
> drivers/tty/serial/msm_serial.h | 18 ++------
> 2 files changed, 48 insertions(+), 68 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

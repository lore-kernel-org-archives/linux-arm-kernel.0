From: davidb@codeaurora.org (David Brown)
Date: Wed, 24 Jul 2013 13:31:07 -0700
Subject: [PATCH 4/4] msm_serial: Send more than 1 character at a time on
 UARTDM
In-Reply-To: <1374691051-28544-5-git-send-email-sboyd@codeaurora.org>
References: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
 <1374691051-28544-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130724203106.GE10926@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 11:37:31AM -0700, Stephen Boyd wrote:
>UARTDM cores have a TX fifo that can accept more than one
>character per register write, but the msm_serial driver currently
>only supports 1 character mode. Add support for this mode of operation
>to speed up the transmit path on DM devices.
>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> drivers/tty/serial/msm_serial.c | 51 ++++++++++++++++++++++++++---------------
> 1 file changed, 32 insertions(+), 19 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

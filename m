From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 21 Sep 2012 14:46:18 -0700
Subject: [PATCH v2] serial: omap: fix the reciever line error case
In-Reply-To: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Fri, 21 Sep 2012 20:07:19 +0530")
References: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87r4pvdp79.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> This patch does the following
> - In case of errors if there least one data character in the RX FIFO
> read it otherwise it may stall the receiver.
>
> This is recommended in the interrupt reset method in the table 23-246 of
> the omap4 TRM.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - Tested on omap4sdp.
> - pm tested hitting off in idle and suspend.
> - v2 changes update the changelogs.
> - Also remove the dummy check as FE , PE , BI and OE are the only
> receiver errors.

Tested-by: Kevin Hilman <khilman@ti.com>

This one also makes the regression I was seeing on 3530/Overo disappear.

Thanks,

Kevin

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Nov 2012 20:40:18 -0700
Subject: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
In-Reply-To: <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
 <1352170552-29564-2-git-send-email-omar.luna@linaro.org>
Message-ID: <509886A2.5060509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 07:55 PM, Omar Ramirez Luna wrote:
> Actually moving it from plat-omap, as this framework/driver code is
> supposed to be under drivers/ folder. The framework should work with
> the current supported OMAP processors (OMAP1+) that have mailbox and
> can be used as a method of interprocessor communication.
> 
> The mailbox hardware (in OMAP) uses a queued mailbox-interrupt mechanism
> that provides a communication channel between processors through a set of
> registers and their associated interrupt signals by sending and receiving
> messages.

> diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h

Is this a public interface to the driver? If so, shouldn't the header be
in include/linux somewhere?

Is this a generic interface to any mailbox driver? If so, then I don't
think having "omap" in the symbol names is appropriate. If the header is
specific to the OMAP driver, I don't think using the very generic
filename "mailbox.h" is appropriate; use omap_mailbox.h instead?

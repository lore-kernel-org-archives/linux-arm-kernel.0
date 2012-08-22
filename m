From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 10:15:14 -0700
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <1345645780-2749-2-git-send-email-arnd@arndb.de>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
Message-ID: <503513A2.1030002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/12 07:29, Arnd Bergmann wrote:
> read_current_timer is used in the get_cycles() function when
> ARM_ARCH_TIMER is set, and that function can be inlined into
> driver modules, so we should export the function to avoid
> errors like
>
> ERROR: "read_current_timer" [drivers/video/udlfb.ko] undefined!
> ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

I ran into this last week but forgot to send the patch. Thanks.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

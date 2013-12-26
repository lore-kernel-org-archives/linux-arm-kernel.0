From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Dec 2013 04:41:18 +0000 (UTC)
Subject: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
In-Reply-To: <1386841969-765-1-git-send-email-rnayak@ti.com>
References: <1386841969-765-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1312260421060.15949@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Dec 2013, Rajendra Nayak wrote:

> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
>  DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
> to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
> where we use uart1 for console, boot fails with DEBUG_LL enabled.
> 
> Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

By the way, for future patches that fix previous commits, please put 
"Fixes:" lines along with your signoffs, and Cc: lines for the original 
patch authors (if they're not you).  I've added the following line in this 
case:

    Fixes: 7dedd346941d ("ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with DEBUG_LL")


regards,

- Paul

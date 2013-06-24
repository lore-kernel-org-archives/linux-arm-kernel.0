From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 24 Jun 2013 12:28:53 +0200
Subject: [PATCH v2 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1372066925-23579-4-git-send-email-ming.lei@canonical.com>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
 <1372066925-23579-4-git-send-email-ming.lei@canonical.com>
Message-ID: <1708070.4u00OSumQU@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 17:42:04 Ming Lei wrote:
> This patch improves this above situation, and the qh will wait for 5
> milliseconds before being unlinked from hardware, if one URB is submitted
> during the period, the qh is move out of unlink wait list and the
> interrupt transfer can be scheduled immediately, not like before: the
> transfer is only linked to hardware until previous unlink is completed.

It seems to me that this logic should be used only if the URB completed
without error.
	
	Regards
		Oliver

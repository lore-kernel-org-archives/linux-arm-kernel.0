From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 10 Jun 2013 10:43:07 +0200
Subject: [RFC PATCH 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <1370791112-18464-2-git-send-email-ming.lei@canonical.com>
References: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
 <1370791112-18464-2-git-send-email-ming.lei@canonical.com>
Message-ID: <1399422.br9htUau7f@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 23:18:28 Ming Lei wrote:
> 2), the biggest change is the situation in which usb_submit_urb() is called
> in complete() callback, so the introduced tasklet schedule delay might be a
> con, but it shouldn't be a big deal:
> 
>         - control/bulk asynchronous transfer isn't sensitive to schedule
>           delay

That is debatable.Missing a frame boundary is expensive because the increased
latency then translates into lower throughput.

	Regards
		Oliver

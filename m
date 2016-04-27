From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Wed, 27 Apr 2016 09:34:09 +0900
Subject: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
In-Reply-To: <20160426142157.GK2749@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
 <20160423034924.GA535@swordfish>
 <20160426142157.GK2749@pathway.suse.cz>
Message-ID: <20160427003409.GA4782@swordfish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (04/26/16 16:21), Petr Mladek wrote:
[..]
> > move printk_nmi_flush_on_panic() to printk.c, and place it next to
> > printk_flush_on_panic() (so we will have two printk "flush-on-panic"
> > functions sitting together). /* printk_nmi_flush() is in printk.h,
> > so it's visible to printk anyway */
> > 
> > it also will let us keep logbuf_lock static, it's a bit too internal
> > to printk to expose it, I think.
> > 
> > IOW, something like this?
> 
> It is rather cosmetic change. I 

oh yes, it is. just to keep similar functionality (flush, zap locks)
in one place (printk).

	-ss

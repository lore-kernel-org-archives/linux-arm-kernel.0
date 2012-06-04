From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 4 Jun 2012 16:23:47 +0100 (BST)
Subject: v3.5-rc1 ARM PXA possible regression
In-Reply-To: <87fwab88o5.fsf@lebrac.rtp-net.org>
Message-ID: <1338823427.35402.YahooMailClassic@web29004.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew and Arnaud,

Yes, that fixed it! I now see kernel messages on the screen.

Thank you for your help.

Regards,
Paul

--- On Mon, 4/6/12, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Andrew Lunn <andrew@lunn.ch>
> writes:
> 
> > Hi Paul
> 
> Hi,
> 
> >
> > I've got the same problem on my kirkwood based QNAP NAS
> box.
> >
> > I bisected it, and the problem patch for me is:
> >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7ff9554bb578ba02166071d2d487b7fc7d860d62
> >
> > printk: convert byte-buffer to variable-length record
> buffer
> >
> > I've not looked further, so i've no idea why this is
> causing problems.
> 
> There has been discussions here about that iirc. I don't
> know when a
> proper fix will be merged but one *very* *ugly* workaround
> is:
> 
> --- linux.orig/kernel/printk.c? 2012-06-03
> 15:26:20.000000000 +0200
> +++ linux/kernel/printk.c? ?
> ???2012-06-03 16:41:24.000000000 +0200
> @@ -228,7 +228,7 @@ static u32 clear_idx;
>  
>  /* record buffer */
>  #if !defined(CONFIG_64BIT) ||
> defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> -#define LOG_ALIGN 4
> +#define LOG_ALIGN 8
>  #else
>  #define LOG_ALIGN 8
>  #endif
> 
> 
> At least it seems to work here.
> 
> Arnaud

From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 6 Oct 2009 18:31:28 +0400
Subject: [PATCH] SA1100: fix building of h3100
In-Reply-To: <20091006104824.GB14717@n2100.arm.linux.org.uk>
References: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
	<20091006104824.GB14717@n2100.arm.linux.org.uk>
Message-ID: <20091006143128.GA3511@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:48 Tue 06 Oct     , Russell King - ARM Linux wrote:
> On Mon, Oct 05, 2009 at 09:50:34PM +0400, Dmitry Artamonow wrote:
> > Both iPaqs h3100 and h3600 currently share the same source
> > file - h3600.c  But Makefile builds it only if CONFIG_SA1100_H3600
> > selected, so selecting just CONFIG_SA1100_H3100 results in
> > "no machine record defined" message and aborted compilation.
> 
> Maybe this is what SA1100_H3XXX was meant for?  Since that symbol's now
> gone, we might as well fix it this way.

Yes, thanks. To be clear - this is a fix meant for 2.6.32.
I think h3600.c should be split in the future anyway, so there's really
no need to revive SA1100_H3XXX.

-- 
Best regards,
Dmitry "MAD" Artamonow

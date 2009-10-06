From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2009 11:48:24 +0100
Subject: [PATCH] SA1100: fix building of h3100
In-Reply-To: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
References: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20091006104824.GB14717@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2009 at 09:50:34PM +0400, Dmitry Artamonow wrote:
> Both iPaqs h3100 and h3600 currently share the same source
> file - h3600.c  But Makefile builds it only if CONFIG_SA1100_H3600
> selected, so selecting just CONFIG_SA1100_H3100 results in
> "no machine record defined" message and aborted compilation.

Maybe this is what SA1100_H3XXX was meant for?  Since that symbol's now
gone, we might as well fix it this way.

From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Tue, 6 Oct 2009 14:51:46 +0200
Subject: [PATCH] SA1100: fix building of h3100
In-Reply-To: <20091006112831.GA15695@n2100.arm.linux.org.uk>
References: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
	<20091006125318.d430a642.kristoffer.ericson@gmail.com>
	<20091006112831.GA15695@n2100.arm.linux.org.uk>
Message-ID: <20091006145146.bb815cf2.kristoffer.ericson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Oct 2009 12:28:31 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Oct 06, 2009 at 12:53:18PM +0200, Kristoffer Ericson wrote:
> > On Mon,  5 Oct 2009 21:50:34 +0400
> > Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > 
> > > Both iPaqs h3100 and h3600 currently share the same source
> > > file - h3600.c  But Makefile builds it only if CONFIG_SA1100_H3600
> > > selected, so selecting just CONFIG_SA1100_H3100 results in
> > > "no machine record defined" message and aborted compilation.
> > > 
> > > Fix it.
> > 
> > Acked
> 
> If there are people seriously looking at H3[16]00 stuff, it would be
> a good idea to move it over to use the proper GPIO support rather
> than continue to rely upon its own version.

Im not looking specificly at the IPAQ stuff, but it comes in
contact with my jornada work. I agree that moving it into general
GPIO support should be the priority.

> 
> Also maybe splitting it into h3100.c and h3600.c, with (if any) common
> bits in h3xxx.c might be an idea?


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

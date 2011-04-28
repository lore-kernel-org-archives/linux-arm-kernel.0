From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 16:27:35 +0100
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
Message-ID: <20110428152735.GU17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 05:27:06PM +0800, Eric Miao wrote:
> Since originally there are only definitions like zreladdr defined in
> Makefile.boot,
> and with AUTO_ZRELADDR, some platforms do not need this definition any
> more, which makes Makefile.boot useless on these platforms. Yet it does now
> look like Makefile.boot is so far the best place for these DTB rules.

Let's get this sorted out right now.  We know that Linus doesn't like
the current situation with lots of data tables in .c files in the kernel.
He explicitly doesn't like the conflicts and churn that it is causing.

If/when we move to DT, do people think that Linus is going to accept
having the DT files in the kernel for all these platforms, and will he
be happy to see stuff like the files containing the OMAP clock definitions
being constantly patched?  Remember, it's *exactly* this data which Linus
wants out of the kernel source.

I suspect the answer to that is no.  So I think we should start right now
with the idea that putting DT files - even the core SoC ones - into the
kernel isn't going to be acceptable.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 17:37:21 +0100
Subject: [PATCH] ARM: localtimer: add header linux/errno.h explicitly
In-Reply-To: <20110930020208.GA19807@S2100-06.ap.freescale.net>
References: <1316798545-21128-1-git-send-email-shawn.guo@linaro.org>
	<20110930020208.GA19807@S2100-06.ap.freescale.net>
Message-ID: <20111001163721.GJ11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 10:02:10AM +0800, Shawn Guo wrote:
> Hi Russell,
> 
> Do you have any comment on this patch?  Otherwise, I will put it into
> patch tracker.

Only that the include should be towards the top of the file rather
than conditionally included.  That avoids potential surprise compile
errors caused by changes in configuration.  (Ok, you may argue that
they shouldn't happen but with the amount of includes we have it's
very difficult to ensure that everything explicitly includes everything
it actually needs.)

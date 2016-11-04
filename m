From: johan@kernel.org (Johan Hovold)
Date: Fri, 4 Nov 2016 14:03:59 +0100
Subject: [PATCH] bus: vexpress-config: fix device reference leak
In-Reply-To: <1478259746.17152.126.camel@arm.com>
References: <1477997017-29103-1-git-send-email-johan@kernel.org>
 <1478259746.17152.126.camel@arm.com>
Message-ID: <20161104130359.GA8671@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:42:26AM +0000, Pawel Moll wrote:
> On Tue, 2016-11-01 at 11:43 +0100, Johan Hovold wrote:
> > Make sure to drop the reference to the parent device taken by
> > class_find_device() after populating the bus.
> > 
> > Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to
> > regmap")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> You're right. May I ask how did you figure it out? The get_device()
> happening in class_find_device() is a bit obscure, so have you simply
> followed places where it's being used or used some static (?) analysis
> tool? If the latter, I'd be very curios to hear what was it :-)

I stumbled over one of these leaks and grepped and searched for more.
I've submitted a few patches this week fixing some of the more obvious
ones, but there are more lurking behind various subsystem wrappers.

Thanks,
Johan

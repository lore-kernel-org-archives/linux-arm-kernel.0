From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 15 Feb 2014 11:19:32 -0800
Subject: [PATCH 01/12] misc: vexpress-syscfg: Add udelay-based delay
In-Reply-To: <1392138636-29240-2-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20140215191932.GA2280@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 05:10:25PM +0000, Pawel Moll wrote:
> It is normally preferable to yield the task
> waiting for syscfg operations (that can take
> up to dozens of milliseconds), but when the
> system is shutting down it may not be possible.

Really?  What happens at shutdown that prevents things from being
scheduled?  Why would you want to busy-loop instead at this point in
time?

thanks,

greg k-h

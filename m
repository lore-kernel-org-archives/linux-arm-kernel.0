From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Oct 2016 22:28:34 +0200
Subject: [PATCH 2/5] staging/vchi: Fix build warnings when formatting
 pointers on aarch64.
In-Reply-To: <20161017194406.1080-3-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-3-eric@anholt.net>
Message-ID: <20161017202834.GA30101@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 12:44:03PM -0700, Eric Anholt wrote:
> The code was generally using "%x" to print and "(unsigned int)" to
> cast the pointers, but we have %p for printing pointers in the same
> format without any broken casts.

I already did this work, it's all checked into my tree, and is in
linux-next now.  You were cc:ed on the patches as well.

Also, please use "%pK" for kernel pointers, you never want to print an
address to userspace unless debugging is enabled, as it is a security
leak.

thanks,

greg k-h

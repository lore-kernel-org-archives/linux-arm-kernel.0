From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 8 Apr 2016 07:07:01 -0700
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20160408140701.GA3547@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
> NULL pointer dereferrence will happen when class driver
> wants to allocate zero length buffer and pool_max[0]
> can't be used, so skip reserved pool in this case.

Why would a driver want to allocate a 0 length buffer?  What driver does
this?

Shouldn't we fix that issue instead?

thanks,

greg k-h

From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 11 Apr 2016 11:01:45 +0800
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <20160408140701.GA3547@kroah.com>
References: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
 <20160408140701.GA3547@kroah.com>
Message-ID: <1460343705.10419.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-08 at 07:07 -0700, Greg Kroah-Hartman wrote:
> On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
> > NULL pointer dereferrence will happen when class driver
> > wants to allocate zero length buffer and pool_max[0]
> > can't be used, so skip reserved pool in this case.
> 
> Why would a driver want to allocate a 0 length buffer?  What driver does
> this?
It's misc/usbtest.c
> 
> Shouldn't we fix that issue instead?
I don't know which way is better, but it seems simple to fix it up in
buffer.c 
> 
> thanks,
> 
> greg k-h

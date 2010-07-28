From: error27@gmail.com (Dan Carpenter)
Date: Wed, 28 Jul 2010 20:01:38 +0200
Subject: [PATCH 01/10] arm: leds: check return value of request_region()
In-Reply-To: <1280335127-23145-1-git-send-email-segooon@gmail.com>
References: <1280335127-23145-1-git-send-email-segooon@gmail.com>
Message-ID: <20100728180138.GO26313@bicker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 08:38:47PM +0400, Kulikov Vasiliy wrote:
> request_region() may fail, if so return -ENOMEM.

I think -EBUSY is more normal, although some people return -ENODEV or
-EIO.  But I would think -EBUSY is the right one.

regards,
dan carpenter

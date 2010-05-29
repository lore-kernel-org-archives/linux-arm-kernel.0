From: davem@davemloft.net (David Miller)
Date: Sat, 29 May 2010 00:15:34 -0700 (PDT)
Subject: [PATCH] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <1274982828-13082-1-git-send-email-eric@eukrea.com>
References: <536177.31761.qm@web51001.mail.re2.yahoo.com>
	<1274982828-13082-1-git-send-email-eric@eukrea.com>
Message-ID: <20100529.001534.57459102.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>
Date: Thu, 27 May 2010 19:53:48 +0200

> * with this patch, if the connection if active before suspend, it
> will be active after resume.
> * before this patch, it was necessary to close the interface and
> reopen it to recover the connection.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>

On resume the PHY should be reset and the link renegotiated (or set to
a fixed speed/duplex if set by the user via ethtool) just like as
happens on ->open().

You seem to be avoiding that here.

If the PHY is not functioning properly after the ->resume() triggered
reset, fix that instead.

I'm not applying this patch, it doesn't look the right thing to do at
all.

From: davem@davemloft.net (David Miller)
Date: Mon, 19 Feb 2018 14:11:37 -0500 (EST)
Subject: [PATCH net 2/4] net/8390: Fix msg_enable patch snafu
In-Reply-To: <db538e6962eb16045ec85c15aee2b9b30eedcce5.1519007130.git.fthain@telegraphics.com.au>
References: <cover.1519007130.git.fthain@telegraphics.com.au>
 <db538e6962eb16045ec85c15aee2b9b30eedcce5.1519007130.git.fthain@telegraphics.com.au>
Message-ID: <20180219.141137.2095980245673495027.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 18 Feb 2018 21:39:17 -0500 (EST)

> The lib8390 module parameter 'msg_enable' doesn't do anything useful:
> it causes an ancient version string to be logged.

Since you are removing the last reference to this 'version' string
you should remove it as well.

I'm surprised the compiler doesn't warn about this.

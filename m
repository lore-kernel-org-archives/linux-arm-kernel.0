From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Jan 2013 15:55:05 -0500
Subject: [PATCH] pinctrl: mvebu: Fix compiler warnings
In-Reply-To: <1357756089-6028-1-git-send-email-andrew@lunn.ch>
References: <1357756089-6028-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130109205505.GZ5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 07:28:09PM +0100, Andrew Lunn wrote:
> match->data is const void * where as dev.platform_data is just void *.
> Add a cast to remove the const, which is causing the compiler warning:
> 
> drivers/pinctrl/mvebu/pinctrl-kirkwood.c:461:26: warning: assignment
> discards 'const' qualifier from pointer target type
> 
> Dove has the exact same warning, so gets the same cast.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 Aug 2016 16:46:10 +0200
Subject: [PATCH] DT: kirkwood: Fix Openblock A6 external GPIO pins
In-Reply-To: <20160815145104.14135-1-jason@lakedaemon.net>
References: <20160815013538.8056-1-jason@lakedaemon.net>
 <20160815145104.14135-1-jason@lakedaemon.net>
Message-ID: <20160817144610.GD3751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 02:51:04PM +0000, Jason Cooper wrote:
> By assigning the pin hog to the pinctrl node, we correctly configure the
> MPPs.  However, they are not available to userspace.
> 
> Fix this by assigning the hogs to the gpio node.
> 
> After this, the following works as expected:
> 
>   # echo 28 >/sys/class/gpio/export
>   # echo low >/sys/class/gpio/gpio28/direction
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

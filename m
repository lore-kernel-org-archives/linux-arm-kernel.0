From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Apr 2014 00:13:08 -0400
Subject: [PATCH] ARM: Kirkwood: T5325: Fix double probe of Codec
In-Reply-To: <1397565608-1830-1-git-send-email-andrew@lunn.ch>
References: <1397565608-1830-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140424041308.GQ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:40:08PM +0200, Andrew Lunn wrote:
> The codec is defined both in DT and the board file. The board file
> however contains platform data which is required in order that the
> codec works. When the DT instantiates the codec before the board files
> does, it is missing the platform data and so fails. Remove the DT node
> until we have a binding which can pass the additional data.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> It would be good to get this into -rc2.

oops, sorry.  This was accidentally placed in my -next queue, not my
-fixes.

Applied to mvebu/dt-fixes.

thx,

Jason.

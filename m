From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 17:37:01 -0400
Subject: [PATCH 2/5] ARM: Kirkwood: Use DT to instansiate codec
In-Reply-To: <1397749994-24983-3-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140417213701.GV28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

First, thanks for following through with the kirkwood DT conversion.

I have one small request below:

On Thu, Apr 17, 2014 at 05:53:11PM +0200, Andrew Lunn wrote:
> Now that the ALC5623 codec has a DT binding, instansiate it using DT
> rather than a platform device.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-t5325.dts |  8 ++++++++
>  arch/arm/mach-mvebu/board-t5325.c    | 15 ---------------
>  2 files changed, 8 insertions(+), 15 deletions(-)

Since the audio device isn't critical to boot, can we split this patch
and the other DT patch in two?  That'll prevent branch
dependency/merge conflicts between mvebu/dt and mvebu/soc.

thx,

Jason.

From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 17 Sep 2016 13:37:53 +0800
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for
 ZTE device
In-Reply-To: <57DC27A9.3060307@codeaurora.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
 <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
 <b549cd51-a81f-b693-e3c2-9e3c598d3d9e@arm.com>
 <20160916163952.GH1041@n2100.armlinux.org.uk>
 <57DC27A9.3060307@codeaurora.org>
Message-ID: <20160917053753.GG7398@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 12:11:05PM -0500, Timur Tabi wrote:
> Russell King - ARM Linux wrote:
> >Maybe what we should've done with ZTE is insisted that they implement
> >a complete new driver, rather than trying to shoe-horn it into PL011
> >even though it is in theory PL011.
> 
> When I suggested that a year ago, I was shot down:
> 
> http://www.spinics.net/lists/arm-kernel/msg455888.html

I still think that's a bad idea.  ZTE is not the first one making such
small customization on PL011, and likely won't be the last one.  We
don't want to clone PL011 driver every time there is a such vendor
hardware coming out, do we?  Having PL011 driver being able to handle
different register layout is very helpful to handle such vendor
variants, IMHO.

I still appreciate rmk's insistence to handle ZTE device with PL011
driver, and the effort of adding a little "infrastructure" to handle
all such possible variants.

Shawn

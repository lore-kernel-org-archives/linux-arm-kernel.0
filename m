From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 30 May 2013 01:51:58 +0200
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <51A682C7.9060605@cogentembedded.com>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
 <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
 <51A682C7.9060605@cogentembedded.com>
Message-ID: <23620997.ZR1QCYhSc2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thursday 30 May 2013 02:35:51 Sergei Shtylyov wrote:
> On 05/30/2013 02:28 AM, Simon Horman wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > The USB_OVCn pins are alternate options for USB over-current detection
> > when using a 3.3V USB interface. As they're not mandatory they can be
> > used independently of the USB PENC pins. Don't group the USB_OVCn and
> > PENC pins to avoid conflicts when the USB_OVCn pins are used by another
> > function.
> > 
> > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I suspect this is needed in -stable. The bug is older than 3.10-rc1.

Is it ? The offending commit is

commit 97d40c4224172451f666febdd865c24b1c3c3fe5
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Thu Mar 7 13:38:51 2013 +0100

    sh-pfc: r8a7779: Add USB pin groups and functions
    
    Signed-off-by: Laurent Pinchart 
<laurent.pinchart+renesas@ideasonboard.com>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>

and got applied to mainline in v3.10-rc1.

-- 
Regards,

Laurent Pinchart

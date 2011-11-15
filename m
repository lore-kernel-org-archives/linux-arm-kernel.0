From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 01:59:33 +0100
Subject: [PATCH] at91: at91-ohci: fix set/get power
In-Reply-To: <CAFumwP08OeGqrNrTAzYeLkB=oZtyMDEoBa9epoHcG_Wjc5CQ8g@mail.gmail.com>
References: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
 <CAFumwP08OeGqrNrTAzYeLkB=oZtyMDEoBa9epoHcG_Wjc5CQ8g@mail.gmail.com>
Message-ID: <20111115005933.GE15318@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:39 Mon 14 Nov     , Andrew Victor wrote:
> hi,
> 
> > in commit aa6e52a35 we introduce the support of overcurrent notification
> > but the set and get of the power without checking if the gpio is valid or not
> 
> > + ? ? ? if (pdata->vbus_pin[port] <= 0)
> > + ? ? ? ? ? ? ? return;
> 
> Shouldn't that rather be:
>    if (!gpio_is_valid(pdata->vbus_pin[port]))
>           return;
Yes should be but 0 is not a valid gpio on at91

I've a patch serie to fix the gpio support for at91 so we can use
gpio_is_valid for 3.3

Best Regards,
J.

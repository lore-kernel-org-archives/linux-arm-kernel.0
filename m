From: stigge@antcom.de (Roland Stigge)
Date: Sat, 28 Jan 2012 11:41:50 +0100
Subject: [PATCH] Fix LPC32XX's clock.c
In-Reply-To: <20120127223211.GA27425@pengutronix.de>
References: <1327673868-19741-1-git-send-email-stigge@antcom.de>
 <20120127223211.GA27425@pengutronix.de>
Message-ID: <4F23D0EE.8000103@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/12 23:32, Wolfram Sang wrote:
>> [clock.c]
> This needs to be split up further to make reviewing easier, I'd
> say. From a glimpse, I'd guess:
> 
> - locking changes - usb fixes - adding MLC NAND - adding ADC

OK, will separate things out. Can move over the changes for ADC and
MLC NAND to the respected driver integration patches (following).

> I dunno, maybe the NXP git has the incremental changes? You should
> really CC Kevin Wells on your patches. Maybe he will wake up again,
> at least with some additional informaition.

Yes, I'm also re-forwarding all my integration patches to Kevin Wells
and his colleagues at NXP who also committed to git.lpclinux.com in
the past.

The patches have different sources, all collected together now:

* http://git.lpclinux.com/ (Kevin Wells et. al., NXP), repositories:
  - linux-2.6.27.8-lpc32xx.git
  - linux-2.6.34-lpc32xx.git
  - linux-2.6.39.2-lpc.git
* http://git.antcom.de/ (my repos)
  - linux-2.6, branch work92105

I basically collected the most recent versions and fixes from the
other different sources together and forward-ported to latest Linux
mainline. (Currently works really well for the WORK Microwave devices
based on LPC3250.) You can find many incremental changes in the above
repositories hopefully clearing things up.

Thanks in advance,

Roland

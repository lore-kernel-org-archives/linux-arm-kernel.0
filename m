From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Jun 2016 10:03:34 +0200
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <B256D81BAE5131468A838E5D7A24364101650C5253@penmbx01>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <20160608202651.GA23604@rob-hp-laptop>
 <20160608203810.GF2466@piout.net>
 <B256D81BAE5131468A838E5D7A24364101650C3632@penmbx01>
 <20160617135448.GI5809@piout.net>
 <B256D81BAE5131468A838E5D7A24364101650C5253@penmbx01>
Message-ID: <20160620080334.GL5809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2016 at 03:16:35 +0000, Yang, Wenyou wrote :
> > Sure, what I mean is that you can try to get the regmap for the SFR in every case.
> > Depending on whether you were able to get it, you can decide to call
> > ohci_at91_port_suspend/resume or not (just test for sfr_regmap != NULL).
> 
> I don't think so. The SFR includes a lot of miscellaneous functions, more than this one.
> 

I know but this is irrelevant to this discussion. If you need to use the
SFR from another driver you will simply get it from that other driver.

I that case, you will try to get "atmel,sama5d2-sfr". It is only present
on sama5d2 so you have enough information to know whether or not you can
use it to suspend/resume.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

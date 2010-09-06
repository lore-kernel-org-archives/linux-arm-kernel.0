From: pieterg@gmx.com (pieterg)
Date: Mon, 6 Sep 2010 15:12:23 +0200
Subject: colibri-pxa300: LCD_LDD / LCD_CS gpio conflict
Message-ID: <201009061512.23705.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In colibri-pxa300.c, line 132, gpio config GPIO62_LCD_CS_N is overriding the 
GPIO62_LCD_LDD_8 configuration, earlier in the pin config table.

As a result, one pixel data line is missing, obviously causing wrong pixel 
data on passive lcd panels.

Not sure what the best workaround should be.
LDD_CS is not available on the colibri evalboard as far as I can see, so we 
might just define GPIO127_LCD_CS_N instead? (till the soc/carrier board 
configs have been split)

Or for now just put GPIO62_LCD_CS_N between
#ifdef CONFIG_FB_PXA_SMARTPANEL?

Rgds, Pieter

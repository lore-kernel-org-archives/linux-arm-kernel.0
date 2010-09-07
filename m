From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 10:43:31 +0800
Subject: colibri-pxa300: LCD_LDD / LCD_CS gpio conflict
In-Reply-To: <201009061512.23705.pieterg@gmx.com>
References: <201009061512.23705.pieterg@gmx.com>
Message-ID: <AANLkTim+h8Wu40LoWue2=TeKykAJmr8=rT48gF5eCX6j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 6, 2010 at 9:12 PM, pieterg <pieterg@gmx.com> wrote:
> In colibri-pxa300.c, line 132, gpio config GPIO62_LCD_CS_N is overriding the
> GPIO62_LCD_LDD_8 configuration, earlier in the pin config table.
>
> As a result, one pixel data line is missing, obviously causing wrong pixel
> data on passive lcd panels.
>
> Not sure what the best workaround should be.
> LDD_CS is not available on the colibri evalboard as far as I can see, so we
> might just define GPIO127_LCD_CS_N instead? (till the soc/carrier board
> configs have been split)
>
> Or for now just put GPIO62_LCD_CS_N between
> #ifdef CONFIG_FB_PXA_SMARTPANEL?
>

Possibly define two groups of LCD pin configurations and select them
when the appropriate LCD expansion card is plugged. If it can be
detected at run-time, that will be perfect, otherwise have to come
up with ugly #ifdef .. #else then.

> Rgds, Pieter
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

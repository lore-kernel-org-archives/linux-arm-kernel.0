From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 May 2016 08:38:55 +0100
Subject: [RFC PATCH 01/21] mfd: uniphier: add UniPhier MFD driver
In-Reply-To: <CAK7LNATmuN647=avdqAMahLU+9Bq4m4TkXe5f7q=pi8m=UrXBg@mail.gmail.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-2-git-send-email-yamada.masahiro@socionext.com>
 <20160510112622.GL19473@dell>
 <CAK7LNATmuN647=avdqAMahLU+9Bq4m4TkXe5f7q=pi8m=UrXBg@mail.gmail.com>
Message-ID: <20160511073855.GQ19473@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2016, Masahiro Yamada wrote:

> Hi Lee,
> 
> 2016-05-10 20:26 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> >> +};
> >> +MODULE_DEVICE_TABLE(of, uniphier_mfd_match);
> >
> > NACK.  Please do not mix MFD and DT registration.
> 
> OK, thanks for review.
> 
> 
> My basic thought was:
> 
>   - Add an MFD node to my DTS only once.
>     If I need to expand it in the future, I will just
>     need to modify drivers/mtd/uniphier-mfd.c.
>     It is just kernel-internal modification, so it does not
>     bother DT binding at all.
> 
>   - Simplify the node topology of DTS.

Just describe the hardware in DT.  If you do so accurately, there
should be no requirement to change it (in theory).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

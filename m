From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 Nov 2013 12:07:42 +0000
Subject: [PATCH 3/7] ARM: ux500: Remove ATAG support for SDI (MMC)
In-Reply-To: <CAPDyKFrd+UHYjZw7=8sf=gmATQ8rPubAVrjWYpbhODak+hOhZQ@mail.gmail.com>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
 <1383732348-18576-4-git-send-email-lee.jones@linaro.org>
 <CAPDyKFrd+UHYjZw7=8sf=gmATQ8rPubAVrjWYpbhODak+hOhZQ@mail.gmail.com>
Message-ID: <20131107120742.GP30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > -struct mmci_platform_data mop500_sdi0_data = {
> > -       .f_max          = 100000000,
> > -       .capabilities   = MMC_CAP_4_BIT_DATA |
> > -                               MMC_CAP_SD_HIGHSPEED |
> > -                               MMC_CAP_MMC_HIGHSPEED |
> > -                               MMC_CAP_ERASE |
> > -                               MMC_CAP_UHS_SDR12 |
> > -                               MMC_CAP_UHS_SDR25,
> 
> I guess all the above caps is having binders in DT then?

They're not there yet, no. But this stuff is not used anymore in
Mainline hence the patch. I attempted to supply bindings for them, but
they were rejected. Would you like to have a stab at that?

We are suffering with some MMC issues presently on Snowball, this
could well be the cause.

> Dito
> Dito

Likewise.

NB: When you post review comments, try not to forget to <snip> all
unrelated cruft. Scrolling down for pages to find them is not optimal.


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

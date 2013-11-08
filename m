From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 Nov 2013 09:26:51 +0000
Subject: [PATCH 3/7] ARM: ux500: Remove ATAG support for SDI (MMC)
In-Reply-To: <CACRpkdYuBL58Pj8EZmVGGxXk8mrOY=YkVwWC1Ho7SH01442z0Q@mail.gmail.com>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
 <1383732348-18576-4-git-send-email-lee.jones@linaro.org>
 <CAPDyKFrd+UHYjZw7=8sf=gmATQ8rPubAVrjWYpbhODak+hOhZQ@mail.gmail.com>
 <20131107120742.GP30901@lee--X1>
 <CACRpkdYuBL58Pj8EZmVGGxXk8mrOY=YkVwWC1Ho7SH01442z0Q@mail.gmail.com>
Message-ID: <20131108092651.GT30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Nov 2013, Linus Walleij wrote:

> On Thu, Nov 7, 2013 at 1:07 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> >> > -struct mmci_platform_data mop500_sdi0_data = {
> >> > -       .f_max          = 100000000,
> >> > -       .capabilities   = MMC_CAP_4_BIT_DATA |
> >> > -                               MMC_CAP_SD_HIGHSPEED |
> >> > -                               MMC_CAP_MMC_HIGHSPEED |
> >> > -                               MMC_CAP_ERASE |
> >> > -                               MMC_CAP_UHS_SDR12 |
> >> > -                               MMC_CAP_UHS_SDR25,
> >>
> >> I guess all the above caps is having binders in DT then?
> >
> > They're not there yet, no. But this stuff is not used anymore in
> > Mainline hence the patch. I attempted to supply bindings for them, but
> > they were rejected. Would you like to have a stab at that?
> 
> Yeah but we basically regressed the ux500 with the patch now
> queued for v3.13:
> commit 49c129519a7a8840767321c38d2eaf84a263529b
> "ARM: ux500: Stop passing MMC's platform data for Device Tree boots"
> 
> Which deleted the passing of this non-yet-DT:ed platform
> data.
> 
> Since it's a regression we need to do a fixup patch for the
> v3.13 series adding it back.

Okay, do you want me to do that?

> Since this patch probably needs to be rewritten on top of
> that I don't merge this patch as of now.

Sure.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

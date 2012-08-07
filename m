From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Tue, 7 Aug 2012 02:56:06 +0000
Subject: =?utf-8?B?7ZqM7IugOiDtmozsi6A6IO2ajOyLoDogW1BBVENIXSBPRFJPSUQtWDogaGtk?=
 =?utf-8?Q?k4412:_Add_new_hardware_based_on_Exynos4412?=
In-Reply-To: <CAOesGMj6BafLCpZjmtyn_ASbpeic_8E0CdYjQGOf3A4_NHfy=Q@mail.gmail.com>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <CAJuYYwSjnQ6z0iUaLCV9guC7yyKH3_pbd1QZe3ELKF-fYNfaqQ@mail.gmail.com>
 <A6A3B7488C419F488E5B13FFD03C08AD2F4362EE@SN2PRD0510MB370.namprd05.prod.outlook.com>
 <CAOesGMh=6QrCmL4EqnSqTxi1nH+8Wn+x=z9BYq8QJCznH3a=zQ@mail.gmail.com>
 <A6A3B7488C419F488E5B13FFD03C08AD2F43688D@SN2PRD0510MB370.namprd05.prod.outlook.com>,
 <CAOesGMj6BafLCpZjmtyn_ASbpeic_8E0CdYjQGOf3A4_NHfy=Q@mail.gmail.com>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F4369FF@SN2PRD0510MB370.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for your advice.
Fortunately I got ODROID-X hardware earlier and am able to boot with mainline kernel.

I will try to do alternative way first with source code kernel 3.0.15, and hope you review the patch if ready.

Regards,
Dongjin.
________________________________________
?? ??: Olof Johansson [olof at lixom.net]
?? ??: 2012? 8? 7? ??? ?? 11:28
?? ??: Dongjin Kim
??: Thomas Abraham; Dongjin Kim; Kukjin Kim; Russell King; Tony Lindgren; Jon Medhurst; Shawn Guo; Uwe Kleine-K?nig; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
??: Re: ??: ??: [PATCH] ODROID-X: hkdk4412: Add new hardware based on Exynos4412

Hi,

On Mon, Aug 6, 2012 at 7:05 PM, Dongjin Kim
<Dongjin.Kim@agreeyamobility.net> wrote:
> Hello,
>
> I am trying to understand what I have to do for device tree.
>
> In order to create dts file for ODROID-X hardware, it seems I may need dts file of EXYNOS4412 SoC.
> But maybe exynos4412.dtsi is not merged yet or not exist, like exynos4210.dtsi or exynos5250.dtsi.
> Obviously it seems not easy to create such a file without SoC datasheet, and I do not have it.
>
> So do I wait for the file to be merged by Samsung or better to create initial dts file cloned from exynos4210.dtsi and modify to have verified nodes with the source/header files?

Ideally they already have one waiting to be submitted, but that might
not be the case. Given that the origenboard design with 4412 is not
yet shipping, I'm guessing the Linaro Samsung engineers might not have
done much work on 4412 yet. Kukjin? Thomas?

> What's your suggestion?

The alternative is to use the data you have available -- i.e. sources
and patches, and craft the device tree from there. The design of 4412
is a derivative from 4210, so that's a good start. Next step would be
to describe the board on top of the SoC, peripherals, etc. Take a look
at how the origen board support was added, and so on.

I ordered an odroid-x several weeks ago but I haven't have a confirmed
shipping date yet. :( I'm not sure how long it'll be before I can help
out, unfortunately.


-Olof

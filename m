From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Tue, 7 Aug 2012 02:05:56 +0000
Subject: =?utf-8?B?7ZqM7IugOiDtmozsi6A6IFtQQVRDSF0gT0RST0lELVg6IGhrZGs0NDEyOiBB?=
 =?utf-8?Q?dd_new_hardware_based_on_Exynos4412?=
In-Reply-To: <CAOesGMh=6QrCmL4EqnSqTxi1nH+8Wn+x=z9BYq8QJCznH3a=zQ@mail.gmail.com>
References: <1344262254-14648-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <CAJuYYwSjnQ6z0iUaLCV9guC7yyKH3_pbd1QZe3ELKF-fYNfaqQ@mail.gmail.com>
 <A6A3B7488C419F488E5B13FFD03C08AD2F4362EE@SN2PRD0510MB370.namprd05.prod.outlook.com>,
 <CAOesGMh=6QrCmL4EqnSqTxi1nH+8Wn+x=z9BYq8QJCznH3a=zQ@mail.gmail.com>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F43688D@SN2PRD0510MB370.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to understand what I have to do for device tree.

In order to create dts file for ODROID-X hardware, it seems I may need dts file of EXYNOS4412 SoC.
But maybe exynos4412.dtsi is not merged yet or not exist, like exynos4210.dtsi or exynos5250.dtsi.
Obviously it seems not easy to create such a file without SoC datasheet, and I do not have it.

So do I wait for the file to be merged by Samsung or better to create initial dts file cloned from exynos4210.dtsi and modify to have verified nodes with the source/header files?

What's your suggestion?

Regards,
Dongjin.
________________________________________
?? ??: Olof Johansson [olof at lixom.net]
?? ??: 2012? 8? 7? ??? ?? 3:33
?? ??: Dongjin Kim
??: Thomas Abraham; Dongjin Kim; Kukjin Kim; Russell King; Tony Lindgren; Jon Medhurst; Shawn Guo; Uwe Kleine-K?nig; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
??: Re: ??: [PATCH] ODROID-X: hkdk4412: Add new hardware based on Exynos4412

Hi,

On Mon, Aug 6, 2012 at 11:16 AM, Dongjin Kim
<Dongjin.Kim@agreeyamobility.net> wrote:
> Hello Tomas,
>
> I am agree with you to look at using device tree and I have some plan for it.
> But as of now I am focusing to bring up the hardware itself with mainline kernel and merge into it.
> I also need some time to look at the requirement of device tree, because I am not familiar with it yet.
>
> Any advice will be welcomed.

Basic rule (that has some flexibility for legacy platforms) is that
the net movement of board support should move from board files to
device-tree based. Introduction of a brand new board like this is a
prime example of something that should be using device tree from day
1.


-Olof

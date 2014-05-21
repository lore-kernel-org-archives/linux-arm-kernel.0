From: chirantan@chromium.org (Chirantan Ekbote)
Date: Wed, 21 May 2014 11:34:55 -0700
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <537CD235.2020304@samsung.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
 <53753443.8010303@gmail.com>
 <CAD=FV=V8UZoeOqEwfx_E015pLM+amTt51LrUa+dk7mTdn=vKgA@mail.gmail.com>
 <53753C17.1090002@gmail.com>
 <CAD=FV=WGa7j_As_NpySxU7OEd_SzuGWK6oxU6UeiJ-4HsoWvvg@mail.gmail.com>
 <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
 <CAASgrz2Nr69tpfC8ka9gbs2OvjLEGsvgAj4vBCFxhsamuFum7w@mail.gmail.com>
 <53754CE2.3000905@gmail.com>
 <CAD=FV=UMoL7i9rg_QtBAqPwisSQyRqRmk8wQhneMXAiLBjTT1A@mail.gmail.com>
 <CAPz6YkU8GDrLj8UkqEQXxxqxWF5_p427wKSDgAp+QPR7WE7Ujg@mail.gmail.com>
 <CAJFHJrrb2XFDZqJh4OuLdFP=J0aR4pGe-WLWKZ7ZpMfUSPGd4Q@mail.gmail.com>
 <5376A726.4000106@samsung.com>
 <CAD=FV=VXSP1TM9qY8PxFuQ+Tq2Ju57VdpzpwsHXqHshQm_havQ@mail.gmail.com>
 <035001cf74f8$0aabdae0$200390a0$@samsung.com>
 <537CD235.2020304@samsung.com>
Message-ID: <CAJFHJrpdVQ6G=-h5J_EgBT8+XSiyvPnNGR2yBDV27i8TDQ7jRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 9:20 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> On 21.05.2014 15:24, Kukjin Kim wrote:
>
>> BTW, since
>> exynos5260, exynos5420 and exynos5800 doesn't support arch timer, we
>> have been using MCT on exynos5 SoCs.
>
> Hmm, I thought arch timer was a core feature of ARM Cortex A15 (and A7)
> cores. Also you mention Exynos5420, while Chirantan's patch removing MCT
> node from exynos5420.dtsi, would suggest that it worked for him fine. (I
> assume it was tested.)
>

I was able to boot both 5420 and 5800 with just the arch timers on our
3.8 based franken-kernel.  The upstream kernel doesn't boot on those
systems with or without the mct so I wasn't able to test there.
Although looking at the upstream device tree now I see that there is
no entry for the arch timer in exynos5420.dtsi.  Maybe it should be
added in?

Chirantan

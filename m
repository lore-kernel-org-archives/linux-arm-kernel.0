From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 May 2018 07:16:45 -0700
Subject: [PATCH 00/12] introduce support for early platform drivers
In-Reply-To: <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
 <20180530194032.982.41562@harbor.lan>
 <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
 <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
Message-ID: <20180531141645.GM5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Geert Uytterhoeven <geert@linux-m68k.org> [180531 06:45]:
> Yes, they should all be drivers.
> 
> Assuming clocksources, clockevents, or primary interrupt controllers are
> special, and thus forcing everyone to use OF_DECLARE for the whole
> subsystem, doesn't fly everywhere.
> 
> Clockevents and interrupt controllers can have a module clock.
> All three can be part of a PM Domain, which requires a struct device to
> be handled properly.

I agree it sure would be nice to have all these as drivers. I believe
SoC specific clockevent using SoC specific clocks is the reason why some
clocks cannot currently be drivers.

Regards,

Tony

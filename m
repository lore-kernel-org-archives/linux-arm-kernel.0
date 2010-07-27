From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Jul 2010 22:11:53 +0900
Subject: [rtc-linux] [PATCH 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <AANLkTimMaNp4JN+f-A=NpuchSfDaTnKBcCeBdjkR8rm1@mail.gmail.com>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
	<1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
	<AANLkTinHlD1fC_Es6P7mcX4-_STNoYxV4wmsKe6KAw_N@mail.gmail.com>
	<006501cb2a39$8b06eb20$a114c160$%kim@samsung.com>
	<AANLkTimMaNp4JN+f-A=NpuchSfDaTnKBcCeBdjkR8rm1@mail.gmail.com>
Message-ID: <001501cb2d8d$4abfbef0$e03f3cd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wan ZongShun wrote:

> 
> 2010/7/23 Kukjin Kim <kgene.kim@samsung.com>:
> > Wan ZongShun wrote:
> >>
> >> 2010/7/21 Kukjin Kim <kgene.kim@samsung.com>:
> >> > From: Taekgyun Ko <taeggyun.ko@samsung.com>
> >> >
> >> > RTC needs to be initialized when BCD registers have invalid value.
> >>
> >> Do you mean that the hardware register does not have default value?
> >> Any results if no initialized value here?
> >>
> > Hi,
> >
> > Yes..I mean that it has no default value.
> > As you know, it has to be keep the previous time value after reset..and the reset
> value is not defined.
> >
> 
> So, reset is no use to this RTC BCD registers, it still keep previous
> time value.
> 
> > So added check that functionality, because if it has no valid BCD value, RTC
> time does not move on.
> > Of course, if we set time at that time, RTC works well...I mean just need initialize
> that.
> >
> 
> Okay,good patch.:)
> 
Thanks ;-)

> In addtion,For making sure to get valid value, it is much better to
> use also 'rtc_valid_tm(tm)' to check returning time value in your
> s3c_rtc_gettime() and s3c_rtc_getalarm(() functions.
> 
Ok..will do it later as per your suggestion.

> 
> >> >
> >> > Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> >> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> > ---
> >> >  drivers/rtc/rtc-s3c.c |   14 ++++++++++++--
> >> >  1 files changed, 12 insertions(+), 2 deletions(-)
> >> >
(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

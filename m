From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 22:11:36 +0900
Subject: [PATCH 2/3] ARM: S5P: Add System define for arch_reset()
In-Reply-To: <AANLkTim2s6syCjpl5v_qVloktrzz27JsSrR6kgWqNHUm@mail.gmail.com>
References: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
	<1277332317-30192-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTim2s6syCjpl5v_qVloktrzz27JsSrR6kgWqNHUm@mail.gmail.com>
Message-ID: <012e01cb139e$c9ac8bc0$5d05a340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Jun 24, 2010 at 7:31 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Jongpill Lee <boyko.lee@samsung.com>
> >
> > This patch adds system define for arch_reset() using Watchdog reset.
> > And adds IO mapping for using WDT.
> 
> Are there any reason to use the WDT to system reset?

Yeah, I already commented about that.
Now Samsung SoC hardware engineer recommends to use the reset of watchdog
instead of software reset by restriction of hardware environment.

> As original purpose of WDT. doesn't it better to use system reset?

Original purpose? I think, WDT can be used as software reset.

> Since we use the WDT reset at other purpose. but if you add the WDT
> reset to system reset.
> then we can't control it. bootloader check the reset reason then
> report something wrong at previous operation.

Yeah, I know your needs. If watchdog reset used as software reset, can't
distinguish who call watchdog reset.
And actually, need to check/debug about abnormal reset status when called
watchdog reset.

> 
> So I want to use system reset as original purpose.
> 
Yes, I think so, if can be used SWRESET, will add that functionality.
But right now...no.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

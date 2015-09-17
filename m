From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 11:43:44 +0200
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <55FA87AA.4040807@gmail.com>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <55FA83D5.9010504@linaro.org> <55FA87AA.4040807@gmail.com>
Message-ID: <1595765.iIuZsGWCYG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 17. September 2015, 17:28:10 schrieb Caesar Wang:
> >> The problem was different semantics of dsb on btw arm32 and arm64,
> >> Here we can convert the dsb with insteading of dsb(sy).
> > 
> > What happens to ARM32 then ?
> 
> The dsb() is ok for ARM32, the ARM32/64 are OK if we can convert the
> dsb() to dsb(sy).
> I believe all drivers with 'dsb()' have same issue on ARM64 platform.

correct ... I read this up in the ARM docs 2 days ago too for something.

The "sy" param is the default, which you are allow to omit, so on arm32 dsb() 
and dsb(sy) are the same.


Heiko

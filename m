From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 12 Oct 2017 17:07:05 +0200
Subject: [PATCH v2 0/4] Make PL031 interrupt optional
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
Message-ID: <20171012150705.zwpkvjhxigcd2puj@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/2017 at 11:21:16 +0100, Russell King - ARM Linux wrote:
> There are some boards out there which have a PL031 RTC, but its
> interrupt is not wired up.  To support these, we need the PL031
> to support the primecell without interrupts.
> 
> When no interrupt is present, there's little point exposing the
> RTC's alarm capabilities, so we omit the alarm-related function
> calls - the RTC merely becomes a source of time-of-day.
> 
> This patch series cleans up the pl031 driver a little, and adds
> support for this configuration.
> 
>  drivers/rtc/rtc-pl031.c | 48 +++++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> v2: update patch 2 & 3 for review comment on v1.
> 

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

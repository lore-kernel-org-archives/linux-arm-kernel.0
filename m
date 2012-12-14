From: russ.dill@gmail.com (Russ Dill)
Date: Fri, 14 Dec 2012 15:58:06 -0800
Subject: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il>
 <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il>
 <509BDAF5.1010703@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB68589@DBDE01.ent.ti.com>
Message-ID: <CA+Bv8XbshAbjyVLH1ZH18Y4nv7k7nb7kym5gjk+ARjUnkFe3dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 9:08 AM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> No we do not have 32k_counter block in AM335x.
>
> If you are referring to 32Khz clock availability alone, then yes, we need to
> get persistent clock and we use RTC 32Khz clock source for it.
> But please note that this is not a 32k_counter block which OMAP family of
> devices has.
>
> The way AM335x works is, we have timers (0-7), timer0 being secure timer.
> We use timer1 and timer2 for clockevent and clocksource and they are driven
> by 26MHz OSC clock currently. So when you go into Low power state, OSC is turned off and you need persistent clock for time keeping, right?
>
> And only persistent clock available is RTC 32khz crystal clock, being RTC is
> in wakeup domain.

RTC domain.

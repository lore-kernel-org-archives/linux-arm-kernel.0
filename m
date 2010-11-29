From: sunder.svit@gmail.com (Sundar)
Date: Mon, 29 Nov 2010 19:31:00 +0530
Subject: [PATCH][ ARM cpu hotplug 2/2 ] Use common cpu hotplug code for
	UX500
In-Reply-To: <AANLkTinmnN+Ta3LCpmL6kfjYLyY8eA8GspEmqEaaS8-p@mail.gmail.com>
References: <AANLkTinOdaYoztaHCkbFhfRtuo4XEVaC+K_7aAB0N28N@mail.gmail.com>
	<AANLkTinmnN+Ta3LCpmL6kfjYLyY8eA8GspEmqEaaS8-p@mail.gmail.com>
Message-ID: <AANLkTi=o=vAHY+ixcRgt7kfqsLP=NsiO6JPwF=+ADbJ9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

> On Mon, Nov 29, 2010 at 3:19 PM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>
>> This patch extracts the common code of the cpu hotplug feature across
>> arm platforms. The goal is to only keep the specific stuff of the
>> platform in the sub-architecture. I have created a hotplug.c file in
>> the ?arm/common directory after studying the cpu hotplug code of
>> omap2, realview, s5pv310, ux500 and tegra. I have extracted 3 main
>> platform dependent functions:
>> ?-platform_enter_lowpower which prepares the platform for low power.
>> ?-platform_do_lowpower on which the cpu will loop until it becomes
>> really plugged (spurious wake up). This function must returned the cpu
>> Id in order to leave the unplug state.
>> ?-platform_leave_lowpower which restore the platform context.
>> ?An ux500 patch is available which uses the common/hotplug.c code.
>> This patch is quite short because the idle / power down functions are
>> not yet upstreamed
>>
>

I had posted a patch which does exactly the same thing sometime ago,
but it got dropped
off from the radar.?The patch set can be referenced
@?http://www.spinics.net/lists/arm-kernel/msg97600.html
I remember getting it Acked by most of the platform maintainers, but
Russell?had some
reservations on that.

Cheers!

--
---------
The views expressed in this email are my personal ones and do not
necessarily echo my employers.

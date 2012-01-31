From: khilman@ti.com (Kevin Hilman)
Date: Tue, 31 Jan 2012 09:29:13 -0800
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <878vkopw2o.fsf@ti.com> (Kevin Hilman's message of "Mon, 30 Jan
 2012 16:14:23 -0800")
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
Message-ID: <87mx93ok5y.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

Kevin Hilman <khilman@ti.com> writes:

> Paul Walmsley <paul@pwsan.com> writes:
>
>> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> pwrdm_pre_transition(), which appears a few lines after these calls,
>> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
>> need to do it twice.
>
> It looks like these two for OMAP4 are surpurfluous since the immediately
> follow a call to pwrdm_pre_transition() as well.
>
> Santosh/Rajendra, please confirm/ack.

So after the discussion, do you want to fold this into the original
patch, or do you want a separate patch?

Kevin

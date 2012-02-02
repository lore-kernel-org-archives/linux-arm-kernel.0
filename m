From: khilman@ti.com (Kevin Hilman)
Date: Thu, 02 Feb 2012 10:14:53 -0800
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com> (Paul
 Walmsley's message of "Wed, 1 Feb 2012 12:27:14 -0700 (MST)")
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
 <87mx93ok5y.fsf@ti.com>
 <alpine.DEB.2.00.1202011218190.10541@utopia.booyaka.com>
Message-ID: <878vkldrvm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 31 Jan 2012, Kevin Hilman wrote:
>
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Paul Walmsley <paul@pwsan.com> writes:
>> >
>> >> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> >> pwrdm_pre_transition(), which appears a few lines after these calls,
>> >> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
>> >> need to do it twice.
>> >
>> > It looks like these two for OMAP4 are surpurfluous since the immediately
>> > follow a call to pwrdm_pre_transition() as well.
>> >
>> > Santosh/Rajendra, please confirm/ack.
>> 
>> So after the discussion, do you want to fold this into the original
>> patch, or do you want a separate patch?
>
> Your changes make sense to me.  I am fine with you adding them into the 
> original patch and adding some credit for you into the commit message.  
> Or you can create a separate patch.

OK, I'll fold it in.

Thanks,

Kevin

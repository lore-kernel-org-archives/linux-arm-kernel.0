From: khilman@ti.com (Kevin Hilman)
Date: Mon, 05 Mar 2012 10:12:15 -0800
Subject: [PATCH] ARM: OMAP2+: voltage: ensure voltage used is exact
 voltage from OPP table
In-Reply-To: <1330940487.2116.119.camel@sokoban> (Tero Kristo's message of
 "Mon, 5 Mar 2012 11:41:27 +0200")
References: <1330728121-26664-1-git-send-email-khilman@ti.com>
 <1330940487.2116.119.camel@sokoban>
Message-ID: <877gyyor28.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2012-03-02 at 14:42 -0800, Kevin Hilman wrote:
>> When using the SMPS regulators to scale voltages, the regulator
>> framework may pass a minimum voltage that is not an exact OPP voltage.
>> For the VC/VP controlled voltage domains, we must ensure that the
>> voltage requested is the exact voltage from the OPP table.  This is
>> especially critical when using SR.
>> 
>> To fix, voltdm_scale() uses the target voltage passed to walk through
>> the OPP voltages until it finds a voltage that is >= one of the OPP
>> voltages.
>
> I have just one question to this, how about smartreflex class1p5? Do we
> have any plans for that one? The old implementation at least was using
> voltdm_scale, so if we modify this function, smartreflex class1p5
> doesn't work anymore.

Since it's not in mainline, that is not my concern at the moment.  We
can worry about SR1.5 when I someone is motivated to push it upstream.

> Otherwise this patch looks good to me.

Thanks for looking.

Kevin

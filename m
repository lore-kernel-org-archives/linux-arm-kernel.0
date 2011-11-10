From: khilman@ti.com (Kevin Hilman)
Date: Thu, 10 Nov 2011 10:33:48 -0800
Subject: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer when
 device is present
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
 (Sanjeev Premi's message of "Wed, 9 Nov 2011 10:11:03 +0000")
References: <1320797670-21460-1-git-send-email-khilman@ti.com>
 <E28AAFD00EFAA646AE3DF9B89CD24A89036E64@DBDE01.ent.ti.com>
Message-ID: <8762irg73n.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Premi, Sanjeev" <premi@ti.com> writes:

>> Current code registers voltage layer details for TWL PMIC even when a
>> TWL has not been registered.  Fix this to only register the TWL with
>> voltage layer when the TWL PMIC is initialized by board-level code.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>

[...]

> I have been out-of-loop from PM for some time. So my query may be
> redundant:
>
> 1) What happens when different PMIC (not TWL series) is registered
>    for AM35x? e.g. TPS65023
>    http://www.spinics.net/lists/linux-omap/msg48630.html
>
> 2) Wouldn't we still fall back into omap3_twl_init()?

I'm not sure I follow the question.

If you're not using a TWL PMIC (or similar derivative) then
omap*_twl_init() should not be called.

If you are using a TWL PMIC, then no, the omap*_twl_init functions
should not be called.

Kevin

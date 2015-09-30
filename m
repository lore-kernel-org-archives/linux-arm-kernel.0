From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Sep 2015 10:08:59 +0100
Subject: [PATCH 1/4] of: Add of_parse_phandle_with_opt_args() helper
 function
In-Reply-To: <CAL_JsqLWPfi9ynLbkzHkpcSHHg3ciwCcAN1uGcjXhnBAXZ74zw@mail.gmail.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
 <1442944336-11754-2-git-send-email-marc.zyngier@arm.com>
 <CAL_JsqLWPfi9ynLbkzHkpcSHHg3ciwCcAN1uGcjXhnBAXZ74zw@mail.gmail.com>
Message-ID: <560BA6AB.3060500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/15 18:28, Rob Herring wrote:
> On Tue, Sep 22, 2015 at 12:52 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> of_parse_phandle_with_args() is slightly inflexible as it doesn't
>> allow the (unusual) case where the #*-cells property is not defined.
>> In order to support this, introduce of_parse_phandle_with_opt_args()
>> which assumes that #*-cells is zero when it is not defined,
> 
> zero or cell_count - 1?

Zero is how the lack of #msi-cells property is interpreted. (cell_count
- 1) is how this is implemented.

> I would be okay with always assuming zero rather than being an error
> if that simplifies things. It is not really the kernel's job to be a
> dtb validator.

I'd be fine with that too. I'd just like it to be a defined behaviour,
not an unexpected side effect.

> Also, I assume this was done for some compatibility? In general, we
> should be explicit, so "#msi-cells = <0>" should be recommended and we
> should update dts files if they are not.

I agree that over time, we should update the existing DTS. But I hear
Mark chanting "Stable DT" behind me, so I'm inclined to provide an
transition path... ;-)

I'll respin the series later today.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

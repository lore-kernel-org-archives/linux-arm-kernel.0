From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 17:50:33 +0530
Subject: [PATCH, RFC 2/8] ARM: twd: register clock event for 1 core SMP
In-Reply-To: <20130219121400.GP23197@arwen.pp.htv.fi>
References: <cover.1361186097.git.afzal@ti.com>
 <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
 <51235076.8040200@ti.com> <20130219121400.GP23197@arwen.pp.htv.fi>
Message-ID: <51236E11.1030900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013 05:44 PM, Felipe Balbi wrote:
> On Tue, Feb 19, 2013 at 03:44:14PM +0530, Santosh Shilimkar wrote:
>> On Monday 18 February 2013 05:07 PM, Afzal Mohammed wrote:
>>> Register percpu local timer for scheduler tick in the case of one core
>>> SMP configuration. In other cases - secondary cpu's as well as boot
>>> cpu's having more than one core, this is being registered as per
>>> existing boot flow, with a difference that they happens after delay
>>> calibration. Registering the clock for tick in case of one core should
>>> be done before Kernel calibrates delay (this is required to boot,
>>> unless local timer is the only one registered for tick). Registering
>>> twd local timer at init_time (which platforms are doing now) helps
>>> achieve that with the proposed change.
>>>
>>> This helps in an almost booting Kernel (minimal) by only relying on
>>> ARM parts for an A9 one core SMP.
>>>
>>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>>> ---
>> As mentioned in cover-letter, I don't think we have good
>> reasoning to make TWD to work with UP configuration. Even
>> you fix the timer code, there are more cascaded dependencies
>> which is not worth the effort.
>
> if CONFIG_SMP_ON_UP is enabled, smp_twd.c can still be compiled, right ?
>
Yep though just from deps pesrpective TWD is made available for ARM SMP
machines as below

config HAVE_ARM_TWD
         bool
         depends on SMP

Regards,
Santosh

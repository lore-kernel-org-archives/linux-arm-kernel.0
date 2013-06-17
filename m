From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 17 Jun 2013 07:32:49 -0700
Subject: [PATCH v2 0/2] Remove unused voltagedomain data for AM33xx
In-Reply-To: <1371474983-29296-1-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Mon, 17 Jun 2013 18:46:21 +0530")
References: <1371474983-29296-1-git-send-email-rnayak@ti.com>
Message-ID: <87wqps959q.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> Hi,
>
> The powerdomain framework currently expects to always have a voltagedomain
> associated with a given powerdomain. We already have AM33xx which
> has no Voltage Controller/Voltage Processor as part of PRCM.
> There are more SoCs' to follow starting with AM437x and DRA7xx
> which do not have VC/VP. All these SoCs', hence do not support any
> form of auto-scaling of voltages, that was possible on earlier OMAPs'
> using the VFSM to trigger an i2c communication to the PMIC automatically
> on hitting a low power state.
>
> Instead of adding dummy voltage domain data files, like was done for the
> AM33xx case, make the powerdomain framework aware of the fact that some
> SoCs' might not really have support for auto-scaling of voltages in hw.
>
> Patches are based of 3.10-rc6 and are boot tested on am335x bone.
>
> Rajendra Nayak (2):
>   ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
>     associated to a pwrdm
>   ARM: AM33xx: Remove the unused voltagedomain data

Thanks, queuing up this series with ack from Santosh and tested-by from
Afzal.  I'll try, but not sure if it can make it for v3.11.

Kevin

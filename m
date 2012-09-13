From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 12 Sep 2012 17:34:41 -0700
Subject: [PATCH v6 0/7] ARM: OMAP2+: PM: introduce the power domains
 functional states
In-Reply-To: <1347443732-7411-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 12 Sep 2012 11:55:25 +0200")
References: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
Message-ID: <87har2rc9q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Here is a re-spin after some comments and suggestions after review
> and discussions.
>
> Implement the functional states for the power domains:
> - unify the API to use the functional states. The new API
>   consists of the pwrdm_set*_fpwrst and pwrdm_read*_fpwrst
>   functions and is the API to use to control the power domains
>   power and logic states,
> - reorganize the powerdomain API in internal and external parts,
>   in powerdomain.h [1]
> - protect the power domain state change by a lock in the
>   functions that read and set the powerdomains next functional state,
> - introduce the functional states for power domains power states and
>   logic power states [2], and the conversion functions between the
>   functional and internal states. The conversion functions are
>   lightweight and generic. The power domains allowed states [3] are
>   defined in the pwrsts and pwrsts_logic_ret fields of the struct
>   powerdomain,
> - program the logic power state of power domains from the functional
>   states, in pwrdm_set*_fpwrst
> - convert the OMAP2/3/4 PM code to use the updated API,
> - provide the power domains statistics by functional states,
> - provide ftrace tracepoints with the functional state,
> - provide error logs in critical code, which makes the development
>   easier.

I just gave this series a round of PM testing.  I tested retention
and off in idle & suspend, with and without CPUidle on 3430/n900,
3530/Overo, 3730/OveroSTORM, 3730/Beagle-xM and 4430/Panda (though only
MPU/CPU ret/off is supported for OMAP4 in mainline.)

All PM tests passed with flying colors.  Nice!

Kevin

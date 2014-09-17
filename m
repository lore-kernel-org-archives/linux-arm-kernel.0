From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Sep 2014 17:48:50 +0100
Subject: [PATCH v4 01/18] ARM64: Move the init of cpu_logical_map(0)
 before unflatten_device_tree()
In-Reply-To: <20140915061632.GA26649@localhost>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-2-git-send-email-hanjun.guo@linaro.org>
 <20140915061632.GA26649@localhost>
Message-ID: <20140917164850.GB7983@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 07:16:32AM +0100, Olof Johansson wrote:
> On Fri, Sep 12, 2014 at 09:59:59PM +0800, Hanjun Guo wrote:
> > It always make sense to initialize CPU0's logical map entry from the
> > hardware values, so move the initialization of cpu_logical_map(0)
> > before unflatten_device_tree() which is needed by ACPI code later.
> > 
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> With or without needs for ACPI, I don't think there's any reason for
> this code to not go in now.

I can see this being of use to psci_init() where I'd like to check
MIGRATE_INFO_TYPE and MIGRATE_INFO_UP_CPU early on for systems with PSCI
0.2+. So moving it at least that early sounds good to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

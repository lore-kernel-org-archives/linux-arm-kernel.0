From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 19:23:12 +0100
Subject: [PATCH 02/16] ARM: l2c: add platform independent core L2 cache
 initialisation
In-Reply-To: <CAL_JsqJDj_JZT_Mo5=Y1NqObX19v7WvuWSrmAZ4UXi9s6-prXA@mail.gmail.com>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1WeosP-0002PO-5m@rmk-PC.arm.linux.org.uk>
 <CAL_JsqJDj_JZT_Mo5=Y1NqObX19v7WvuWSrmAZ4UXi9s6-prXA@mail.gmail.com>
Message-ID: <20140428182312.GR26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:54:58PM -0500, Rob Herring wrote:
> This function should be a nop if there is no DT node matching, so we
> don't really need to trigger calling it based on machine_desc values.
> If we do that, then we can have aux_mask and aux_val values of 0 for
> both also mean don't do any aux ctrl setup. That would help minimize
> the machine_desc for many platforms.

Calling it with both set to zero results in the auxiliary control register
being cleared to zero.  We don't want that to happen.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

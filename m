From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 20 Mar 2012 16:27:28 -0700
Subject: i.MX: Convert v4/v5 based SoCs to common clock framework
In-Reply-To: <4F674659.40207@gmail.com>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
 <4F674659.40207@gmail.com>
Message-ID: <CAJOA=zPXJL_ssa0M4SG3iN5xH=6MfWD0N3A29H5Ek26L4VORZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 7:44 AM, Rob Herring <robherring2@gmail.com> wrote:
> Do we want to move all clock code to drivers/clk? I'm not saying it has
> to be done now, but is that a goal?

My knee jerk response is to say "no".  Back in January a similar topic
came up for the AT91 CPUidle driver migrating to drivers/cpuidle/.
See Russell's reply here:
http://article.gmane.org/gmane.linux.ports.arm.kernel/147849

If a platform's clock code lives in a silo and is nicely walled off
from other platform-specific bits then migration to drivers/clk/ is
possible.  In practice I think that more complex clock code and data
will have a hard time doing so.  Even the simple task of sharing a
header which exposes commonly used register addresses, offsets and
widths starts to get complicated when some of the code/data that uses
it lives in arch/* and some of it lives in drivers/*

Regards,
Mike

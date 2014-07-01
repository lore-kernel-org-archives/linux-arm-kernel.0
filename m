From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Jul 2014 18:08:53 +0100
Subject: [RFC PATCH 0/6] kernel: Add support for restart notifier call
 chain
In-Reply-To: <53B2BB74.7050300@roeck-us.net>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
 <20140630195946.GI32514@n2100.arm.linux.org.uk>
 <20140630202851.GA12888@roeck-us.net>
 <20140701112413.GQ18313@arm.com> <53B2BB74.7050300@roeck-us.net>
Message-ID: <20140701170853.GX18313@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 02:45:24PM +0100, Guenter Roeck wrote:
> On 07/01/2014 04:24 AM, Catalin Marinas wrote:
> > On Mon, Jun 30, 2014 at 09:28:51PM +0100, Guenter Roeck wrote:
> >> What is restart-poweroff supposed to do in the first place, and why
> >> doesn't it call machine_restart() ? If it is what I think it is, ie
> >> a fallback for pm_power_off, it could be made generic and does not
> >> really have to depend on ARM.
> >
> > I think this one pretends to do a power-off via restart. It could call
> > machine_restart() but this only passes the default reboot_mode to
> > arm_pm_restart().
> 
> Unless one sets reboot_mode first. See my proposed patch in
> https://lkml.org/lkml/2014/6/30/792.

It looks fine to me.

-- 
Catalin

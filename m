From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 May 2016 17:49:10 +0100
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
 <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Message-ID: <20160523164909.GF4976@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 12:44:02PM -0400, Jon Masters wrote:
> Hi Mark,
> 
> On 05/17/2016 08:46 AM, Mark Rutland wrote:
> > On Tue, May 17, 2016 at 03:06:03PM +0300, Aleksey Makarov wrote:
> >> From: Jon Masters <jcm@redhat.com>
> >>
> >> This patch adds support for ACPI_TABLE_UPGRADE for ARM64
> > 
> > This feels like a tool to paper over problems rather than solve them.
> 
> Generally, it's an arrow in the quiver used to triage problems, and then
> solve them by getting firmware updates made.

Ok. The feature is _hideously_ misnamed for that purpose, however.

> > If vendors are shipping horrendously broken tables today, clearly no
> > software has ever really supported them. So why add workarounds?
> 
> That's not (always) the case. These patches help with:
> 
> 1). During development of a platform, it is much easier to debug
> problems with tables if you can test replacement ones without having to
> respin the firmware. In the server world, you usually don't have the
> firmware source code, so to get it respun could be days-weeks even if
> you are working with the authors closely. We have practically used this
> feature on a number of platforms already and it will continue.

I was under the impression that that was already possible with GRUB
today (though I see below this may not be the case).

> 2). They empower (advanced) users and developers to work around problems
> that they find on platforms. Sure, we want firmware to always be fixed
> and working well, but it is better if folks have the tools.
> 
> > Why is this necessary? Is there a particular case for this, or is this
> > just for parity with x86?
> 
> The use cases are as above. It's also required for parity with x86
> functionality on servers.

Parity for case 1 above, or is this used in other scenarios on x86
today?

> > IMO it would be better to put pressure on vendors to fix their FW and
> > provide sensible OS-agnostic update mechanisms.
> 
> It's easier to put pressure on them after we know what the problems are.
> I agree that alternative update mechanisms are also good. We also have
> the ability (but it is not implemented on ARM) in GRUB2 to override ACPI
> tables, BUT it's kinda atrophied on all arches and requires that you
> rebuild GRUB with an additional module.

This feels like something that could/should be rectified.

> The reality is that by incorporating this feature we are able to
> provide the same capability that already exists on x86 systems for
> ACPI table triage.

To be clear, I do not disagree that this feature can be useful for that
case. I am just concerned that this is easily abused, and the
description implies a more general set of use cases than we would like.

Thanks,
Mark.

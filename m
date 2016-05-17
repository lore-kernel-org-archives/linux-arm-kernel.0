From: jcm@redhat.com (Jon Masters)
Date: Tue, 17 May 2016 12:44:02 -0400
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <20160517124629.GE14955@leverpostej>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
Message-ID: <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 05/17/2016 08:46 AM, Mark Rutland wrote:
> On Tue, May 17, 2016 at 03:06:03PM +0300, Aleksey Makarov wrote:
>> From: Jon Masters <jcm@redhat.com>
>>
>> This patch adds support for ACPI_TABLE_UPGRADE for ARM64
> 
> This feels like a tool to paper over problems rather than solve them.

Generally, it's an arrow in the quiver used to triage problems, and then
solve them by getting firmware updates made.

> If vendors are shipping horrendously broken tables today, clearly no
> software has ever really supported them. So why add workarounds?

That's not (always) the case. These patches help with:

1). During development of a platform, it is much easier to debug
problems with tables if you can test replacement ones without having to
respin the firmware. In the server world, you usually don't have the
firmware source code, so to get it respun could be days-weeks even if
you are working with the authors closely. We have practically used this
feature on a number of platforms already and it will continue.

2). They empower (advanced) users and developers to work around problems
that they find on platforms. Sure, we want firmware to always be fixed
and working well, but it is better if folks have the tools.

> Why is this necessary? Is there a particular case for this, or is this
> just for parity with x86?

The use cases are as above. It's also required for parity with x86
functionality on servers.

> IMO it would be better to put pressure on vendors to fix their FW and
> provide sensible OS-agnostic update mechanisms.

It's easier to put pressure on them after we know what the problems are.
I agree that alternative update mechanisms are also good. We also have
the ability (but it is not implemented on ARM) in GRUB2 to override ACPI
tables, BUT it's kinda atrophied on all arches and requires that you
rebuild GRUB with an additional module. The reality is that by
incorporating this feature we are able to provide the same capability
that already exists on x86 systems for ACPI table triage.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

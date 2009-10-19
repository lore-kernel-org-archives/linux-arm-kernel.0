From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 19 Oct 2009 11:33:11 -0700
Subject: [PATCH 38/46] davinci: fix compilation error when using
	mach/system.h
In-Reply-To: <20091019141346.GD13614@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon\, 19 Oct 2009 15\:13\:46 +0100")
References: <1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<20091019141346.GD13614@n2100.arm.linux.org.uk>
Message-ID: <87my3ns07s.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 16, 2009 at 12:09:42PM -0700, Kevin Hilman wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>> 
>> include/mach/system.h uses the cpu_do_idle() function which is
>> defined in asm/proc-fns.h. Without this patch including system.h
>> leads to error of the sort:
>> 
>> error: implicit declaration of function 'cpu_do_idle'
>
> The right answer might actually be to ensure that arch/arm/kernel/process.c
> includes this file, so that all mach/system.h files don't have to.

Maybe it should be more explicit, but at least on 2.6.32, process.c
already triggers an include of <asm/proc-fns.h> (linux/mm.h ->
asm/pgtable.h -> asm/proc-fns.h.

IIRC, the problem was not with arch/arm/kernel/process.c other
mach-davinci files using <mach/system.h> for some reason.

After Sergei's major #include cleanup for mach-davinci/*, I don't
think this is actually necessary anymore.

Sekhar, I'll drop this patch from davinci-next unless you think this
is still necessary for some reason.

Kevin

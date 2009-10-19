From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 19:35:57 +0100
Subject: [PATCH 38/46] davinci: fix compilation error when using
	mach/system.h
In-Reply-To: <87my3ns07s.fsf@deeprootsystems.com>
References: <1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<20091019141346.GD13614@n2100.arm.linux.org.uk>
	<87my3ns07s.fsf@deeprootsystems.com>
Message-ID: <20091019183557.GJ13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 11:33:11AM -0700, Kevin Hilman wrote:
> Maybe it should be more explicit, but at least on 2.6.32, process.c
> already triggers an include of <asm/proc-fns.h> (linux/mm.h ->
> asm/pgtable.h -> asm/proc-fns.h.
> 
> IIRC, the problem was not with arch/arm/kernel/process.c other
> mach-davinci files using <mach/system.h> for some reason.

Ok.  Note that nothing else other than process.c should be using
mach/system.h (it's a private include file for it) so it sounds
like the include cleanup did the right thing.

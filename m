From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 15:13:46 +0100
Subject: [PATCH 38/46] davinci: fix compilation error when using
	mach/system.h
In-Reply-To: <1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
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
Message-ID: <20091019141346.GD13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2009 at 12:09:42PM -0700, Kevin Hilman wrote:
> From: Sekhar Nori <nsekhar@ti.com>
> 
> include/mach/system.h uses the cpu_do_idle() function which is
> defined in asm/proc-fns.h. Without this patch including system.h
> leads to error of the sort:
> 
> error: implicit declaration of function 'cpu_do_idle'

The right answer might actually be to ensure that arch/arm/kernel/process.c
includes this file, so that all mach/system.h files don't have to.

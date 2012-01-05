From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 15:01:40 +0000
Subject: [PATCH RFC] arm: Define cpu_logical_map when CONFIG_SMP is not set
In-Reply-To: <1325767486-6392-1-git-send-email-hamo.by@gmail.com>
References: <1325767486-6392-1-git-send-email-hamo.by@gmail.com>
Message-ID: <20120105150140.GX11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 08:44:46PM +0800, hamo.by at gmail.com wrote:
> From: Yang Bai <hamo.by@gmail.com>
> 
> If CONFIG_SMP is not set, define cpu_logical_map(cpu) as
> (cpu), this fixes the problem described in this mail:
> https://lkml.org/lkml/2012/1/2/142

This doesn't solve the reported problem.  asm/smp.h should not be included
by any .c file, and won't be included by linux/smp.h if CONFIG_SMP is not
set.

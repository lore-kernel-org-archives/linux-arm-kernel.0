From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Aug 2013 17:39:39 +0100
Subject: [PATCHv3 0/5] arm64: initial CPU hotplug support
In-Reply-To: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130830163938.GI4650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 05:20:23PM +0100, Mark Rutland wrote:
> The following patches add basic HOTPLUG_CPU support to arm64, which
> combined with appropriate firmware (e.g. [1]) can be used to power CPUs
> up and down dynamically.

Just for the record, couple of points:

- as we will be expanding the PSCI operations with cpu_suspend, it makes
  more sense to decouple it from SMP and rename smp_operations to
  cpu_operations (or something else without 'smp').
- migrate_irqs() is pretty generic. You can look at arm and other
  architectures and maybe (later) move the code somewhere in
  kernel/irq/.

Otherwise the patches look good.

Thanks.

-- 
Catalin

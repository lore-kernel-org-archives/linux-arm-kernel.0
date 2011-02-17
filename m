From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Feb 2011 16:24:21 +0000
Subject: [PATCH] ARM: pmu: avoid setting IRQ affinity on UP systems
In-Reply-To: <1297771899-23209-1-git-send-email-will.deacon@arm.com>
References: <1297771899-23209-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110217162421.GC941@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 12:11:39PM +0000, Will Deacon wrote:
> Now that we can execute a CONFIG_SMP kernel on a uniprocessor system,
> extra care has to be taken in the PMU IRQ affinity setting code to
> ensure that we don't always fail to initialise.
> 
> This patch changes the CPU PMU initialisation code so that when we
> only have a single IRQ, whose affinity can not be changed at the
> controller, we report success (0) rather than -EINVAL.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Reported-by: Avik Sil <avik.sil@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Look good!

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie

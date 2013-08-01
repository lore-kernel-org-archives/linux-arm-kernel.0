From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 14:41:19 +0100
Subject: [PATCH] ARM: kexec: validate CPU hotplug support
In-Reply-To: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
References: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130801134119.GG24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 04:48:51PM -0600, Stephen Warren wrote:
> +int platform_can_cpu_hotplug(void)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !smp_ops.cpu_kill)
> +		return 0;

This is an inappropriate usage of IS_ENABLED().  When hotplug CPU is
disabled, there is no cpu_kill member in smp_ops, so this leads to
build failure.

Dropping your patch.

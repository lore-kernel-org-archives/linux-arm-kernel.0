From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Feb 2017 11:24:46 +0100 (CET)
Subject: [RFC PATCH 07/33] irqchip/gic-v3-its: Macro-ize
 its_send_single_command
In-Reply-To: <1484648454-21216-8-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.20.1702131122070.3619@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Marc Zyngier wrote:
> +
> +static __its_send_single_cmd(its_send_single_command, its_cmd_builder_t,
> +			     struct its_collection, its_build_sync_cmd)

I'm fine with that macro magic, but the above is very unintuitive as it
looks like a normal function.

The way this is done in other places is to have:

#define BUILD_CMD_FUNC(name,....) \
....

and then have

BUILD_CMD_FUNC(its_send_single_command, ....);

That makes it entirely obvious that this is macro magic.

Thanks,

	tglx

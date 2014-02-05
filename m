From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 06 Feb 2014 00:11:39 +0100
Subject: [PATCH] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <52F2C52B.60001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 11:59 PM, Gregory CLEMENT wrote:
> Until now the clock providers were initialized in the order found in
> the device tree. This led to have the dependencies between the clocks
> not respected: children clocks could be initialized before their
> parent clocks.
>
> Instead of forcing each platform to manage its own initialization order,
> this patch adds this work inside the framework itself.
>
> Using the data of the device tree the of_clk_init function now delayed
> the initialization of a clock provider if its parent provider was not
> ready yet.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> [...]
> this patch could solve the issues we get on severals mvebu platform
> since 3.14-rc1. This is an alternate solution of the patch set sent by
> Sebastian. However as it modifies the clock framework itself, it is
> more sensible.
>
> I find this solution more elegant than changing the order of the
> initialization of the clock at the platform level. However as it
> should be tested on more platforms that only the mvebu ones, it would
> take some time, and I don't want to still have "broken" platform
> during more release candidate. So at the end this patch should be part
> of the 3.15 kernel.

Gregory,

I admit, your patch is more general and I am looking forward to revert
the reorder fix as soon as this is ready :)

BTW, what happened to the early device discussion? Couldn't this be
picked up here to allow -EPROBE_DEFER also for those early drivers?

Sebastian

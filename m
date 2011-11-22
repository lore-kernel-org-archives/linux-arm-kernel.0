From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 22 Nov 2011 13:07:14 +0000
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <1321926047-14211-6-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
Message-ID: <201111221307.14942.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 November 2011, Mike Turquette wrote:
> Introduces kobject support for the common struct clk, exports per-clk
> data via read-only callbacks and models the clk tree topology in sysfs.
> 
> Also adds support for generating the clk tree in clk_init and migrating
> nodes when input sources are switches in clk_set_parent.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
>  drivers/clk/Kconfig     |   10 +++
>  drivers/clk/Makefile    |    1 +
>  drivers/clk/clk-sysfs.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk.c       |    5 +-
>  include/linux/clk.h     |   36 ++++++++-
>  5 files changed, 248 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/clk/clk-sysfs.c

Since this introduces a new top-level hierarchy in sysfs, it certainly needs
to be reviewed by Greg K-H (on Cc now). Also, you have to add a proper
documentation for every new node and attribute in Documentation/ABI along
with the code.

> +static struct kobject *clk_kobj;
> +LIST_HEAD(kobj_list);

The list head should be static.

	Arnd

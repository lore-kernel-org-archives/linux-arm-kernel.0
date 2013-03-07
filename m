From: harvey.harrison@gmail.com (Harvey Harrison)
Date: Wed, 6 Mar 2013 16:49:46 -0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Message-ID: <CAHLZz11PR6E7-yhrxwRi=HWo9tWByH5FUArDqfXQh6N0C_x0tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 4:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>         clk[cluster] = clk_get_sys(name, NULL);
> -       if (!IS_ERR(clk[cluster])) {
> +       if (!IS_ERR_OR_NULL(clk[cluster])) {
>                 pr_debug("%s: clk: %p & freq table: %p, cluster: %d\n",
>                                 __func__, clk[cluster], freq_table[cluster],
>                                 cluster);


You seem pretty attached to IS_ERR_OR_NULL here.

Harvey

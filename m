From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Dec 2013 16:38:18 -0800
Subject: [PATCH v12 05/08] ARM: hi3xxx: add smp support
In-Reply-To: <1386748497-11290-6-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Wed, 11 Dec 2013 15:54:54 +0800")
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
 <1386748497-11290-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87y53jm1s5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Enable SMP support on hi3xxx platform
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
> Tested-by: Li Xin <li.xin@linaro.org>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

This one has checkpatch errors too:

ERROR: do not initialise statics to 0 or NULL
#267: FILE: arch/arm/mach-hi3xxx/platsmp.c:20:
+static void __iomem *ctrl_base = NULL;

ERROR: space prohibited before that close parenthesis ')'
#282: FILE: arch/arm/mach-hi3xxx/platsmp.c:35:
+	return readl_relaxed(ctrl_base + ((cpu - 1 ) << 2));

I fixed these up locally too, but my generosity is running out.

Kevin

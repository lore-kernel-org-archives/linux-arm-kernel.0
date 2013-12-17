From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 17 Dec 2013 13:33:27 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <20131217090005.1e04ff7b@amdc2363>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
 <CAKohpo=vkZRSQ5Xk-Tsm9QVy8h2F5Ehpm4Y8JWi5xjx0OD72tw@mail.gmail.com>
 <20131217090005.1e04ff7b@amdc2363>
Message-ID: <CAKohpo=GtXGEJZSfRB9Rs-KtXYumZRMANFZTzVD94P9pXvuOrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2013 13:30, Lukasz Majewski <l.majewski@samsung.com> wrote:
> When I first looked into the patch - it was almost identical to the
> exynos4210-cpufreq.c or exynos4x12-cpufreq.c files.
>
> Also I didn't spot the code characteristic to IKS. It seems like the
> code in this file is not aware if it runs on A7 or A15.

This code is only written for A15, this is what the log says. And it will
require updates for A7 to be controlled by this driver and then we
can't use cpufreq-cpu0 for it.

You might not use IKS for 5420 at all, I said it is also an optional feature
available if required.

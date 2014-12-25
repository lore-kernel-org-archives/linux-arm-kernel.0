From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 25 Dec 2014 16:48:31 +0800
Subject: kernel panic when booting on exynos 5440
Message-ID: <CACVXFVNCZdMyHQ1fzZDGs7h7X9vWmMVBJFRqWs7_P=WBQUYk1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

In your commit fce9e5bb2(ARM: EXYNOS: Add support for
mapping PMU base address via DT), 'pmu_base_addr' is
only parsed for very limited machines from the table of
'exynos_dt_pmu_match'.  For other boards, 'pmu_base_addr'
will keep its default value of null, then panic() is triggered.

What do you think about the problem?

Thanks,
Ming Lei

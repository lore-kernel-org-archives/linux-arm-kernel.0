From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 13 Jun 2014 09:29:46 -0400 (EDT)
Subject: [PATCH] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <CADWw7Oh=A_cg_hqu8DZ1t_iacOGgWediLp3K3viFYHMNAPkqRw@mail.gmail.com>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <20140607181221.GB25068@e102568-lin.cambridge.arm.com>
 <CAD=FV=X17PeJ6JPE9Qyc1QT07AvA2PTE69Q87gz9a6MdUHgi4A@mail.gmail.com>
 <20140609223831.GB16889@e102568-lin.cambridge.arm.com>
 <CANuQgHHxAhTNYX-JAEdRkO=PMYT4A5GwXcuQfiqwE0CEkQyR+w@mail.gmail.com>
 <CAD=FV=V5_RRNkgA7Rk7XbQw9m1qh6-RJA8arW7ZRU=QbWAPa+w@mail.gmail.com>
 <alpine.LFD.2.11.1406101146140.25775@knanqh.ubzr>
 <CADWw7OjqK3MAuqCHuv-WS3Bb2+2Q-FXth+7hqtwFoyAP6pyYhA@mail.gmail.com>
 <CAD=FV=ULFx0GPp_mnEfouZF+m4h_RYE6WQu48N0WbFWrFv8-BA@mail.gmail.com>
 <5398758F.4080306@samsung.com>
 <CADWw7Oh=A_cg_hqu8DZ1t_iacOGgWediLp3K3viFYHMNAPkqRw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406130922190.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jun 2014, Chander Kashyap wrote:

> This patch is effectively changing the mcpm_entry_point address from
> nsbase + 0x1c to nsbase + 0x8
> 
> Hence while integrating with mainline u-boot we need to take care for
> new mcpm_entry_point address.

Why not inserting a NOP as the first instruction then? That way the 
offset will remain the same.


Nicolas

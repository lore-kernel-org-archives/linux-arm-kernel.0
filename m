From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Oct 2016 13:11:37 -0200
Subject: [PATCH] irqchip: gic-v3-its: fix entry size mask for GITS_BASER
In-Reply-To: <1476716446-28646-1-git-send-email-vladimir.murzin@arm.com>
References: <1476716446-28646-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CAOMZO5BSGda6VUgkReOvfBHsZJQnZ25EA7Bj_Rhmz8XYMz_MMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 1:00 PM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> Entry Size in GITS_BASER<n> occupies 5 bits [52:48], but we mask out 8
> bits.
>
> Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")

Looks like it needs the following tag then:

Cc: <stable@vger.kernel.org> # 3.19+

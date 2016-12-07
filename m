From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 7 Dec 2016 12:00:18 +0530
Subject: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <148e4d35-da65-a212-1490-c2d902dd4410@lechnology.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
 <148e4d35-da65-a212-1490-c2d902dd4410@lechnology.com>
Message-ID: <94b2151a-7e9e-3e77-f3da-df2fa3b66848@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2016 07:24 AM, David Lechner wrote:
> On 12/05/2016 04:09 AM, Bartosz Golaszewski wrote:
>> The aemif clock is added twice to the lookup table in da850.c. This
>> breaks the children list of pll0_sysclk3 as we're using the same list
>> links in struct clk. When calling clk_set_rate(), we get stuck in
>> propagate_rate().
> 
> &emac_clk is used twice in this list as well. Shouldn't we fix it too? I
> would expect that it causes the same problem.

Yes, indeed.

Thanks,
Sekhar

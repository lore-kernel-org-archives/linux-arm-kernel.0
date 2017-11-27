From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 27 Nov 2017 18:12:59 +0530
Subject: [PATCH 2/2] ARM: davinci: make davinci_soc_info structures const
In-Reply-To: <1508148504-2771-3-git-send-email-bhumirks@gmail.com>
References: <1508148504-2771-1-git-send-email-bhumirks@gmail.com>
 <1508148504-2771-3-git-send-email-bhumirks@gmail.com>
Message-ID: <19265c2a-4ae4-a2f8-3ddf-01c2a4c2b11a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 October 2017 03:38 PM, Bhumika Goyal wrote:
> This is a followup patch for [PATCH 1/2].

This line is not relevant once the patch gets committed.

> 
> Make the structures const as they are either passed to the function

Patch description should be readable independent of subject line so we
need to be more specific than "the structures"

> davinci_common_init having the argument as const or their field cpu_clks
> of type struct clk_lookup * is passed to the function davinci_clk_init.
> So, the fields are never modified and the structures can be const. 
> 
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

I made fixes to commit description per above and here is the updated text.

"
ARM: davinci: make davinci_soc_info structures const

Make davinci_soc_info structures const as they are either passed to the
function davinci_common_init having the argument as const or their field
cpu_clks of type struct clk_lookup * is passed to the function
davinci_clk_init.

So, the fields are never modified and the structures can be const.

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
[nsekhar at ti.com: minor commit message adjustment]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
"

With that I applied the patch to v4.16/fixes-non-critical

Thanks,
Sekhar

From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 27 Jul 2016 19:45:13 -0300
Subject: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of memory
 ranges in device tree
In-Reply-To: <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
Message-ID: <3562841.ROYbCgkeeq@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am Dienstag, 19 Juli 2016, 23:28:13 schrieb Geoff Levand:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> The end address of "reg" attribute in device tree's memory should be
> inclusive.

Actually, there's a bug/inconsistency in kexec-tools right now.

crashdump-arm.c expect usablemem_rgns.ranges[i].end to be the last byte in 
the range, but crashdump-powerpc.c, crashdump-ppc64.c and fs2dt.c expect it 
to be the first byte after the range.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center

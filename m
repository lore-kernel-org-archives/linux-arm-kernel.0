From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 6 Aug 2017 18:19:19 +0300
Subject: [PATCH v2 2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
In-Reply-To: <20170806151714.108596802@cogentembedded.com>
References: <20170806151714.108596802@cogentembedded.com>
Message-ID: <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2017 06:14 PM, Sergei Shtylyov wrote:

> of_irq_get() may return 0 as well as a nagative error number on failure,

    Oops, forgot to kill comma...

> (and never on success), however omap44xx_prm_late_init() regards 0 as a
> valid IRQ -- fix this.
> 
> Fixes: a8f83aefcd5a ("ARM: OMAP4+: PRM: register interrupt information from DT")
> Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

MBR, Sergei

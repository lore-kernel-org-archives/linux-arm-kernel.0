From: ralf@linux-mips.org (Ralf Baechle)
Date: Wed, 10 Feb 2016 10:01:06 +0100
Subject: [PATCH] MIPS: pci-mt7620: Fix return value check in
 mt7620_pci_probe()
In-Reply-To: <56B613D3.2070709@openwrt.org>
References: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
 <56B613D3.2070709@openwrt.org>
Message-ID: <20160210090106.GA10352@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 04:40:03PM +0100, John Crispin wrote:

> On 06/02/2016 15:24, weiyj_lk at 163.com wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > In case of error, the function devm_ioremap_resource() returns
> > ERR_PTR() and never returns NULL. The NULL test in the return
> > value check should be replaced with IS_ERR().
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Hi,
> 
> thanks for the fix.
> 
> Acked-by: John Crispin <blogic@openwrt.org>
> 
> @Ralf: can you merge this via LMO with the next PR please ?
> 
> @mbgg: ignore the patch please it is for the legacy MIPS SoCs

Applied.  Thanks folks,

  Ralf

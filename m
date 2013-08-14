From: Barry.Song@csr.com (Barry Song)
Date: Wed, 14 Aug 2013 09:16:22 +0000
Subject: [PATCH 25/29] drivers/spi/spi-sirf.c: simplify use of
 devm_ioremap_resource
In-Reply-To: <1376471493-22215-26-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376471493-22215-26-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012A3BCC66@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Julia Lawall [mailto:Julia.Lawall at lip6.fr]
> Sent: Wednesday, August 14, 2013 5:11 PM
> To: Barry Song
> Cc: kernel-janitors at vger.kernel.org; Mark Brown;
> linux-arm-kernel at lists.infradead.org; linux-spi at vger.kernel.org;
> linux-kernel at vger.kernel.org
> Subject: [PATCH 25/29] drivers/spi/spi-sirf.c: simplify use of
> devm_ioremap_resource
> 
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Remove unneeded error handling on the result of a call to
> platform_get_resource when the value is passed to devm_ioremap_resource.
> 
> Move the call to platform_get_resource adjacent to the call to
> devm_ioremap_resource to make the connection between them more clear.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression pdev,res,n,e,e1;
> expression ret != 0;
> identifier l;
> @@
> 
> - res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>   ... when != res
> - if (res == NULL) { ... \(goto l;\|return ret;\) }
>   ... when != res
> + res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>   e = devm_ioremap_resource(e1, res);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Barry Song <Baohua.Song@csr.com>

> 
> ---
>  drivers/spi/spi-sirf.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
 


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

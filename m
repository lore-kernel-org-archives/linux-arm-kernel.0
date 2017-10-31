From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Tue, 31 Oct 2017 01:42:30 +0100
Subject: linux-next: manual merge of the spi-nor tree with the imx-mxs tree
In-Reply-To: <20171030181551.skcvt4mr4br7rtn2@sirena.co.uk>
References: <20171030181551.skcvt4mr4br7rtn2@sirena.co.uk>
Message-ID: <d38cf683-c7a8-51b1-896a-ff1fda0f64f9@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

+ Marek

Mark, thanks for this report.

Shawn, Yuan, if I don't make a mistake, patch "dt-bindings: mtd: add sst25wf040b
and en25s64 to sip-nor list" was not submitted to the linux-mtd mailing list
hence was neither reviewed nor acked by any spi-nor maintainer. If so, such a
patch should then be taken from the spi-nor/next branch of the l2-mtd tree.

So Shawn, could you please remove this patch from your tree ?

Yuan, could you please submit your patch to the linux-mtd mailing list for
proper review ?

Best regards,

Cyrille


Le 30/10/2017 ? 19:15, Mark Brown a ?crit :
> Hi Cyrille,
> 
> Today's linux-next merge of the spi-nor tree got a conflict in:
> 
>   Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> 
> between commit:
> 
>   b07815d4eaf65 ("dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list")
> 
> from the imx-mxs tree and commit:
> 
>    282e45dc64d1 ("mtd: spi-nor: Add support for mr25h128")
> 
> from the spi-nor tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> index 4cab5d85cf6f,956bb046e599..000000000000
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@@ -13,7 -13,7 +13,8 @@@ Required properties
>                    at25df321a
>                    at25df641
>                    at26df081a
>  +                 en25s64
> +                  mr25h128
>                    mr25h256
>                    mr25h10
>                    mr25h40
> 

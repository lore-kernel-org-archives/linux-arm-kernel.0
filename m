From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Apr 2017 16:40:27 +0200
Subject: [PATCH v2] dmaengine: sun4i: fix invalid argument
In-Reply-To: <3e98596a-0322-e4f1-7cc2-9b0eaceb4465@free.fr>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
 <584a2c53-100b-945b-d665-cef3fa856526@free.fr>
 <20170421082417.7cqtevwuhjvfgjcx@lukather>
 <3e98596a-0322-e4f1-7cc2-9b0eaceb4465@free.fr>
Message-ID: <20170421144027.oll2x3tbb3lwiyfo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 10:43:20AM +0200, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> The "pchans_used" field is an unsigned long array.
> 
> for_each_clear_bit_from() expects an unsigned long pointer,
> not an array address.
> 
> $ make C=2 drivers/dma/sun4i-dma.o
>   CHECK   drivers/dma/sun4i-dma.c
> drivers/dma/sun4i-dma.c:241:9: warning: incorrect type in argument 1 (different base types)
> drivers/dma/sun4i-dma.c:241:9:    expected unsigned long const *p
> drivers/dma/sun4i-dma.c:241:9:    got unsigned long ( *<noident> )[1]
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170421/75899912/attachment.sig>

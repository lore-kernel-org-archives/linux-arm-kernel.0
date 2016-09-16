From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 10:50:52 +0200
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
In-Reply-To: <20160905111948.553487be@canb.auug.org.au>
References: <20160905111948.553487be@canb.auug.org.au>
 <CGME20160916085054eucas1p261bf6f0fb00e860fb819139557ffe5bb@eucas1p2.samsung.com>
Message-ID: <531f80d6-4cf6-ae83-7cb6-e002a6e8f63f@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2016 03:19 AM, Stephen Rothwell wrote:
> Hi Krzysztof,
> 
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
> 
>   arch/arm64/boot/dts/exynos/exynos7.dtsi
> 
> between commit:
> 
>   585dcacac6bb ("arm64: dts: Fix broken architected timer interrupt trigger")
> 
> from the arm-soc tree and commit:
> 
>   36d1c9cd07cd ("arm64: dts: exynos: Use human-friendly symbols for timer interrupt flags")
> 
> from the samsung-krzk tree.
> 
> I fixed it up (I *think* - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

The fix is correct, for the record:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Merge conflict was (unfortunately) expected. In general, the
multiple-platform-at-once patches are conflict prone. Especially in this
case, Marc's patch ("arm64: dts: Fix broken architected...") could be
split per architecture.

Best regards,
Krzysztof

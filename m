From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 22:09:20 +0100
Subject: [PATCH 14/15] ARM: cns3xxx: don't export static symbol
In-Reply-To: <1426092997-30605-15-git-send-email-Julia.Lawall@lip6.fr>
References: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
 <1426092997-30605-15-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <34582069.IEgAMbDRxk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 17:56:36 Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> type T;
> identifier f;
> @@
> 
> static T f (...) { ... }
> 
> @@
> identifier r.f;
> declarer name EXPORT_SYMBOL;
> @@
> 
> -EXPORT_SYMBOL(f);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Looks good. Krzysztof, do you want to pick this up and send me a
pull request together with other patches, or should I apply this
to the arm-soc fixes directly?

	Arnd

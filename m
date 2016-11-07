From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Nov 2016 13:18:49 -0800
Subject: [PATCH] ARM: zx: Fix error handling
In-Reply-To: <20161030081010.14735-1-christophe.jaillet@wanadoo.fr>
References: <20161030081010.14735-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161107211849.GB2106@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 09:10:10AM +0100, Christophe JAILLET wrote:
> 'devm_ioremap_resource()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> 'return -EIO;' could also be turned into 'return PTR_ERR(pcubase);' in
> order to propagate the error value.

Applied to fixes-non-critical. Thanks!


-Olof

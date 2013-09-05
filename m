From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Sep 2013 13:43:06 -0600
Subject: [PATCH] ARM: tegra: throw the unique chip ID into the entropy pool
In-Reply-To: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
References: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5228DECA.4090601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2013 09:28 AM, Linus Walleij wrote:
> This adds a hook at common late init to extract the 64 bits of
> chip-unique data and throw it into the entropy pool to make it
> more device-unique.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Stephen: since I don't have the Tegra reference manual I don't
> know what "UID" means, but if it means "unique ID" then this
> patch should be relevant for initializing the entropy pool.

I believe that's what it means, although even the TRM doesn't actually say.

I'll try and remember to apply this after the merge window.

Note that the UID value appears to be incorrect on anything other than
Tegra20; I'll file an internal bug to track that down.

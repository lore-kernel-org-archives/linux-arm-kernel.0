From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 18 Jun 2014 10:25:02 +0100
Subject: [PATCH] efi/arm64: efistub: remove local copy of linux_banner
In-Reply-To: <CAKv+Gu8auFu=rxtDpZy4tkfPiZK7ERUeRDvymzQYi9AhVUxW+Q@mail.gmail.com>
References: <1402657911-7779-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140618085059.GB24049@console-pimps.org>
 <CAKv+Gu8auFu=rxtDpZy4tkfPiZK7ERUeRDvymzQYi9AhVUxW+Q@mail.gmail.com>
Message-ID: <20140618092502.GD24049@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun, at 11:12:28AM, Ard Biesheuvel wrote:
> 
> This just removes the duplicate definition of linux_banner, *not* the
> reference to it a couple of lines down. IOW, the DT bindings and
> everything behind it are not affected at all by this patch.
> The reason it works fine for arm64 is that its stub is part of the
> kernel proper, so the reference will bind to the global definition
> instead.
 
Aha, thanks.

> What will be affected is 32-bit ARM, as its stub is not part of the
> kernel proper. In this case, we will propose an alternative [and
> better] way of allowing the stub to reference linux_banner, i.e.,
> without having to redefine it at the C level. We will take this into
> account when we propose the next round of efistub patches for ARM.

No complaints from me.

-- 
Matt Fleming, Intel Open Source Technology Center

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Feb 2013 17:38:20 +0100
Subject: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <CACRpkdYV5w6BksUjXvXs=88BovUyXgRt-vXSD0twjRpzbZcvFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 9:43 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:

> When using deferred driver probing, PCI host controller drivers may
> actually require this function after the init stage.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

There seem to be a proliferation of these patches now.

Isn't this just papering over the real problem? The discarding
of __init sections need to happen *after* all deferred probes
are complete, lest we have to remove *all* __init sections from
*all* drivers in the kernel, don't we?

Yours,
Linus Walleij

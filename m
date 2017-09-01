From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 1 Sep 2017 10:21:28 +0100
Subject: [PATCH v3 0/3] Split default display handling out from VGA arbiter
In-Reply-To: <20170901072744.2409-1-dja@axtens.net>
References: <20170901072744.2409-1-dja@axtens.net>
Message-ID: <CAKv+Gu84njSF5uOvNtknGdOd5auU7zw9scFeTq5v-=OhExgOqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2017 at 08:27, Daniel Axtens <dja@axtens.net> wrote:
> This patch set:
>
>  - splits the default display handling out from VGA arbiter, into its
>    own file and behind its own Kconfig option (and gives the functions
>    better names).
>
>  - adds extra detection of default devices. To be nominated, the vga
>    arbiter and platform hooks must not have nominated a default. A
>    card will then only be nominated if it has a driver attached and
>    has IO or memory decoding enabled.
>
>  - adds relevant documentation.
>
> The practical impact of this is improved X autoconfiguration on some
> arm64 systems.
>
> Changes in v3:
>
>  - Add documentation - thanks Daniel Vetter for pointing it out.
>
>  - Clarify explanations. Thanks to everyone for continuing to bear
>    with my incomplete understanding of PCI and provide some clarity.
>
>  - Split refactoring and adding functionality.
>
> Changes in v2: https://www.spinics.net/lists/linux-pci/msg64007.html
>
> Drop all the powerpc patches. [explanation snipped]
>
> v1: https://www.spinics.net/lists/linux-pci/msg63581.html
>

If we are all in agreement that fixing X is not an option, I think
this is a reasonable approach

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

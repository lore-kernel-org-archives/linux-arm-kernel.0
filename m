From: robh@kernel.org (Rob Herring)
Date: Thu, 4 Aug 2016 12:05:33 -0500
Subject: [PATCH v3] reset: uniphier: add reset controller driver for
 UniPhier SoCs
In-Reply-To: <1470111510-21247-1-git-send-email-yamada.masahiro@socionext.com>
References: <1470111510-21247-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160804170533.GA11467@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 01:18:29PM +0900, Masahiro Yamada wrote:
> This is the initial commit for UniPhier reset controller driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3:
>   - Fix examples in binding document to add specific compatible string
>   - Assign each reset signal with a separate ID
>   - Simplify reset_control operations
>   - Unify to a single file because code is short enough now.
> 
> Changes in v2:
>   Changes suggested by Philipp Zabel:
>   - Unify multiple module_platform_driver() boilerplates into one
>   - Unify tiny driver code and decrease the number of files
>   - Invert the logic of .deassert_val, changing it into .assert_val
>   - Show error code when failed to get regmap
>   - Add a binding document
>   - Support more reset signals
> 
>  .../devicetree/bindings/reset/uniphier-reset.txt   |  93 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   1 +
>  drivers/reset/Kconfig                              |  10 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-uniphier.c                     | 440 +++++++++++++++++++++
>  5 files changed, 545 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
>  create mode 100644 drivers/reset/reset-uniphier.c

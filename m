From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 May 2016 14:08:45 +0200
Subject: [PATCH v8 2/3] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
References: <cover.1462543457.git.chunkeey@googlemail.com>
 <535f785bf6116c0fb6f46afbb77e6d4bd3ef5f60.1462543458.git.chunkeey@googlemail.com>
Message-ID: <CACRpkdaeZ14hfz-gRetRcdj8NzzyqigV1ZtDSWAwveFxwAgt0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 8, 2016 at 3:08 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:

> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds support for defining memory-mapped GPIOs which
> are compatible with the existing gpio-mmio interface.

Overall very nice, just waiting for the next version.

> The first user for this binding is "wd,mbl-gpio".

And that binding defines that we have a register named "dat".

> +       if (of_property_read_bool(dev->of_node, "no-output"))

And then this too.

Do we want these generic MMIO bindings (dat, no-output)
in a special document like
Documentation/devicetree/bindings/gpio/gpio-mmio.txt?

Going forward?

This patch set mainly deals with refactorings, but in the
long run we want to slim things down a bit and use standard
bindings I think.

Yours,
Linus Walleij

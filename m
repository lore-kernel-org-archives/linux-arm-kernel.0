From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 11 Jun 2018 14:43:59 +0200
Subject: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller
 property to gph2
In-Reply-To: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPcVqaeYoU=tht5GSyEunnboG-+Mxo96LCDewbqDjCfy-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2018 at 4:15 PM, Pawe? Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
> This commit adds missing interrupt-controller property to gph2 block,

Just "Add missing". See:
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151

> to silence following warnings during build
>   /soc/pinctrl at e0200000/gph2: Missing interrupt-controller or interrupt-map property
>
> Observed on not yet mainlined, an S5PV210 based
> Samsung Galaxy S (i9000) phone.

The warning is not reproduceable (as you mentioned board is not
present in mainline) thus please skip it. Instead, either describe
existing reason for this change (e.g. because bindings require it for
node of every bank of pins supporting GPIO interrupts) or include this
in series mainlining new board (where the reason will be - it will be
used by new board etc).

Best regards,
Krzysztof

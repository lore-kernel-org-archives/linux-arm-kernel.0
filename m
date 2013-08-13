From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 13 Aug 2013 13:45:22 +0200
Subject: [PATCH 0/2] ARM: dts: AM33XX: node definition cleanups
In-Reply-To: <1376154311-10184-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1376154311-10184-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <520A1C52.7070401@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Few TI folks to review and test.

On 10/08/2013 19:05, Javier Martinez Canillas wrote:
> Hi,
>
> While reviewing the submission of a DT file for a new board
> based on the am3352 SoC, I noticed that am33xx*.dts files needed
> some cleanups. All am33xx based board files redefine device nodes
> that are already defined in the included am33xx.dtsi file.
>
> This not only makes the DTS harder to maintain without any benefit
> but also leaks SoC internal details to board files such as how the
> OCP interconnect is modeled (currently just a flat representation)
> and the addresses of some IP modules that are part of the SoC and
> are not going to change from board to board.
>
> This patch-set cleans these board files and is composed of the
> following patches:
>
> [PATCH 1/2] ARM: dts: AM33XX: use pinmux node defined in included
> [PATCH 2/2] ARM: dts: AM33XX: don't redefine OCP bus and device
>
> NOTE: I don't own any of these am33xx based boards so I was only
> able to build test the changes. However I compared the generated
> dtb before and after the changes and the disassembled DTS with
> dtc -I dtb -O dts foo.dtb > bar.dts are identical.
>
> Even though the binary dtb is the same and there shouldn't be
> any visible changes, boot testing will be highly appreciated.

Thanks it looks good to me.

Regards,
Benoit

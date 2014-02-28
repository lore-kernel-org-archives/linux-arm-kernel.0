From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Feb 2014 10:37:46 -0800
Subject: [PATCH v2 1/9] ARM: centralize common multi-platform kconfig
 options
In-Reply-To: <1392153119-23248-2-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAGa+x84M++1vetN1fQJYVCc9fBL5HQWc4WJ_6y9Nmst0XHXK8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 1:11 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <robh@kernel.org>
>
> Multi-platform requires various kconfig options to be selected, so
> platforms don't need to select them individually.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

FYI... this recently hit arm-soc/for-next and according to my bisect,
is the cause for two new boot failures[1] for sunxi_defconfig on
cubieboard and cubie2.  The previous build/boot passed on both
boards[2].   Interestingly, both boards boot fine with
multi_v7_defconfig though.

There's zero console output on the boards, and I haven't dug further
since I still have to pack for a trip tomorrow.

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-February/002615.html
[2] http://lists.linaro.org/pipermail/kernel-build-reports/2014-February/002613.html

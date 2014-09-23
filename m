From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 11:46:20 +0200
Subject: [PATCH 1/4] pinctrl: imx: detect uninitialized pins
In-Reply-To: <6d676a88eb82a47f8fa9e16abbc768e3e9ac236a.1410020458.git.stefan@agner.ch>
References: <cover.1410020458.git.stefan@agner.ch>
 <6d676a88eb82a47f8fa9e16abbc768e3e9ac236a.1410020458.git.stefan@agner.ch>
Message-ID: <CACRpkdbzvyN0ecP2JA6LhYkPYhe_vJTrLvx4WOW73SRyoMLPEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 6, 2014 at 6:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> The pinctrl driver initialized the register offsets for the pins
> with 0. On Vybrid an offset of 0 is a valid offset for the pinctrl
> mux register. So far, this was solved using the ZERO_OFFSET_VALID
> flag which allowed offsets of 0. However, this does not allow to
> verify whether a pins struct imx_pmx_func was initialized or not.
>
> Use signed offset values for register offsets and initialize those
> with -1 in order to detect uninitialized offset values reliable.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij

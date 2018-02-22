From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:47:39 +0100
Subject: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function
 eXpander
In-Reply-To: <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> ST Multi-Function eXpander (MFX) can be used as GPIO expander.
> It has 16 fast GPIOs and can have 8 extra alternate GPIOs
> when other MFX features are not enabled.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

As mentioned I think this driver needs to:

- Move to drivers/pinctrl/pinctrl-stmfx.c similar to the sx150x controller.
- Pass a regmap around instead of the custom accessor functions.
- Maybe refactor and reuse STMPE infrastructure

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 15:39:56 +0200
Subject: [PATCH] spi: pl022: Add clk_{un}prepare() support in runtime PM
In-Reply-To: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
References: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
Message-ID: <CACRpkdbHegZAw+9XXzOb5UPPqJvzoNfPJ5aPDhuwWWhWunuv8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 12:37 PM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:

> clk_{un}prepare is mandatory for platforms using common clock framework. Add
> clk_{un}prepare() support for spi-pl022 runtime PM.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>

This driver does clk_prepare/unprepare at probe
and removed, so I guess what you're trying to say is that
on your platform the clk_unprepare() process context call
is needed to save power?

Please elaborate...

Yours,
Linus Walleij

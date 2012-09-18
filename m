From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 18 Sep 2012 09:39:09 +0530
Subject: [PATCH] spi: pl022: Add clk_{un}prepare() support in runtime PM
In-Reply-To: <CACRpkdbHegZAw+9XXzOb5UPPqJvzoNfPJ5aPDhuwWWhWunuv8w@mail.gmail.com>
References: <1f784b72399e0e96414f00866b209e2e218065af.1347877746.git.vipulkumar.samar@st.com>
 <CACRpkdbHegZAw+9XXzOb5UPPqJvzoNfPJ5aPDhuwWWhWunuv8w@mail.gmail.com>
Message-ID: <CAOh2x==GY6xvyWmLJtpR68x1kiFWO8F85RwS6VfHjJA8YdhgvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 7:09 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This driver does clk_prepare/unprepare at probe
> and removed, so I guess what you're trying to say is that
> on your platform the clk_unprepare() process context call
> is needed to save power?
>
> Please elaborate...

Hi Linus,

Yes, we don't need to call prepare() again atleast for SPEAr. You are correct.
I saw the driver after a long time :)
Can you please elaborate, why can't i see any clk_disable/enable calls anywhere
else from probe. If i remember correctly, earlier we used to enable/disable
clk after transfers and also during suspend/resume.

The amba layer is taking care of interface clock only and not
functional clock. So
i believe that's not the magic code. :)

--
viresh

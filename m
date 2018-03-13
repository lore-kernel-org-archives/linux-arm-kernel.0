From: dianders@chromium.org (Doug Anderson)
Date: Tue, 13 Mar 2018 14:57:51 -0700
Subject: [PATCH] clk: rockchip: Add 1.6GHz PLL rate
In-Reply-To: <20180313203719.75639-1-dbasehore@chromium.org>
References: <20180313203719.75639-1-dbasehore@chromium.org>
Message-ID: <CAD=FV=UK-Rnto+iH8TSuTyzt010HT8Ujk0TX74hA1D5Lh4HfOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 13, 2018 at 1:37 PM, Derek Basehore <dbasehore@chromium.org> wrote:
> We need this rate to generate 100, 200, and 228.57MHz from the same
> PLL. 228.57MHz is useful for a pixel clock when the VPLL is used for
> and external display.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3399.c | 1 +
>  1 file changed, 1 insertion(+)

Looks good to me.  I spent a little bit of time poking at this and I
agreed it's the best way to make 1.6 GHz in
<http://crosreview.com/956677>.  Lin Huang at Rockchip also said:

> yes, we also use this setting for 1.6GHz in our internal branch.

...and they seem to agree this is a sane setting.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

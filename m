From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 9 Oct 2012 22:50:47 +0530
Subject: [PATCH 04/11] fsmc/nand: Accept nand timing parameters via DT
In-Reply-To: <54eda40e56e8ea02ed9c5332ca6d3fb90d617cc7.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <54eda40e56e8ea02ed9c5332ca6d3fb90d617cc7.1349778821.git.vipin.kumar@st.com>
Message-ID: <CAOh2x==1UA-9yDX=S6zGtJ-NwGkQuxStE5WTh6qpWAK7Dw68nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 4:14 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt

> +- nand-timings-enabled: Indicates if the timing parameters are passed
> +  via DT
> +- nand-timings,tclr:
> +- nand-timings,tar:
> +- nand-timings,thiz:
> +- nand-timings,thold:
> +- nand-timings,twait:
> +- nand-timings,tset: All these timing parameters come from the actual
> +  nand device specification. Each of this represents a number of time
> +  period of hclk ie a number 4 in thold with hclk = 166MHz means that
> +  thold = (1000 / 166) * 4 ns = 24.09ns

Are they specific to fsmc controller or nand memory type? If to fsmc then
please add my

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

else
I would suggest to add these to mtd bindings instead, so that same fields
can be used by multiple drivers....

Similar approach is used for mmc controllers too.

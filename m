From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 May 2017 18:01:11 +0200
Subject: [RFC v1 2/3] interconnect: Add Qualcomm msm8916 interconnect
 provider driver
In-Reply-To: <20170515153527.27649-3-georgi.djakov@linaro.org>
References: <20170515153527.27649-1-georgi.djakov@linaro.org>
 <20170515153527.27649-3-georgi.djakov@linaro.org>
Message-ID: <CAMuHMdXM3f+P8ZyydxnO5z2g3F2n2c3KzfDFbC6jYgZJt+1ULw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

On Mon, May 15, 2017 at 5:35 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> --- /dev/null
> +++ b/drivers/interconnect/qcom/interconnect_msm8916.c

> +struct qcom_interconnect_node {
> +       struct interconnect_node node;
> +       unsigned int id;

4 byte gap due to alignment rules on 64-bit.

> +       unsigned char *name;
> +       struct interconnect_node *links[8];
> +       int num_links;
> +       int port;
> +       int buswidth;

4 byte gap due to alignment rules.

> +       u64 ib;
> +       u64 ab;
> +       u64 rate;
> +};

You can avoid the gaps by putting members of the same size and alignment
together.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

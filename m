From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 11:13:29 -0300
Subject: [PATCH v3 3/3] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <1403700096-13014-3-git-send-email-denis@eukrea.com>
References: <1403700096-13014-1-git-send-email-denis@eukrea.com>
 <1403700096-13014-3-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5CSARSPA2K94pQc6osC+8-4jPZsYvV2bQybCXCASmohSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 9:41 AM, Denis Carikli <denis@eukrea.com> wrote:

>  int __init mx25_clocks_init(void)
>  {
> -       __mx25_clocks_init(24000000);
> +       void __iomem *ccm;
> +
> +       ccm = ioremap(MX25_CRM_BASE_ADDR, SZ_16K);

Shouldn't the ccm base address be retrieved from dt?

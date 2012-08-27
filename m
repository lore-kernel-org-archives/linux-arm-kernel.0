From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Mon, 27 Aug 2012 11:27:33 +0530
Subject: [PATCH 5/13] arch/arm: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1345996865-32082-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345996865-32082-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CADTbHxqm9Nktcn++-+GFqX8n_CwNzgp79XRJGf21-eDgtm8jsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 26, 2012 at 9:30 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
> clk_enable, and clk_disable and clk_unprepare.  They make the code more
> concise, and ensure that clk_unprepare is called when clk_enable fails.
>
> A simplified version of the semantic patch that introduces calls to these
> functions is as follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression e;
> @@
>
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>
> @@
> expression e;
> @@
>
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---
>  arch/arm/common/sa1111.c   |    3 +--
>  arch/arm/common/timer-sp.c |   16 ++++------------
>  arch/arm/kernel/smp_twd.c  |   13 +++----------
>  3 files changed, 8 insertions(+), 24 deletions(-)
>

Reviewed-by: Pankaj Jangra <jangra.pankaj9@gmail.com>

Regards,
Pankaj Jangra

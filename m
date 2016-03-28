From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 27 Mar 2016 21:26:35 -0300
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
Message-ID: <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 11:44 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Good catch!
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> I will fix imx6q-sabresd.dtsi when this patch gets applied.

After thinking more about it, I think the correct fix is to revert
5c5fb40de8f143 ("PCI: imx6: Add support for active-low reset GPIO") so
that we do not break old dtb's.

Then a new dt property can be added if someone needs gpio active high PCI reset.

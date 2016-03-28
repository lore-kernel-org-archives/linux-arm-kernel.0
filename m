From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 28 Mar 2016 12:59:45 -0700
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
Message-ID: <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 5:26 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Mar 27, 2016 at 11:44 AM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Good catch!
>>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> I will fix imx6q-sabresd.dtsi when this patch gets applied.
>
> After thinking more about it, I think the correct fix is to revert
> 5c5fb40de8f143 ("PCI: imx6: Add support for active-low reset GPIO") so
> that we do not break old dtb's.
>
> Then a new dt property can be added if someone needs gpio active high PCI reset.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Fabio,

I would agree with you on this - 5c5fb40de8f143 ("PCI: imx6: Add
support for active-low reset GPIO")  should be reverted.

I just finished bisecting an issue to this specific patch only to find
out Krzysztof found it a few days ago ;) Thanks Krzysztof.

Tim

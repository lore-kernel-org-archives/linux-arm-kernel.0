From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2016 19:13:18 -0300
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
 <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
 <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
Message-ID: <CAOMZO5DwuBcpL85GYjTV9yy_ZZB33PDY3TfzwkS1WK03hfkhqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 7:06 PM, Tim Harvey <tharvey@gateworks.com> wrote:

>> On imx6qdl-sabresd.dtsi the PCI reset gpio polarity is set to high,
>> which is not correct, so the Wifi card could be detected even with
>> 5c5fb40de8f. So two errors in sequence and PCI still works on this
>> board :-)
>
> ouch - two wrongs did make a right!
>
> It's not too easy to tell how many IMX6 boards incorrectly specify
> their reset-gpio polarity. I don't know what the best way to determine
> what boards use the IMX6 pcie host controller. Is there a dtc usage
> that will display the compiled dtb's then we grep out 'compatible =
> "fsl,imx6q-pcie"' to at least get the list of boards to inspect? I'm
> curious if its just one or two boards that incorrectly specify the
> polarity of their PCI reset.

In order to keep old dtb's working we should simply ignore the GPIO
flags passed in the 'reset-gpio' property.

That's why we need a revert. Just sent a v2, BTW.

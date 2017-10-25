From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Oct 2017 08:34:28 -0500
Subject: [PATCH] phy: add combo phy driver for HiSilicon STB SoCs
In-Reply-To: <20171024151202.GF6403@dragon>
References: <1508042882-20922-1-git-send-email-shawnguo@kernel.org>
 <20171023222850.ecavz6jm2mnoplea@rob-hp-laptop> <20171024064108.GC6403@dragon>
 <20171024151202.GF6403@dragon>
Message-ID: <CAL_JsqKFuKJb5tvWCg-mMNzmLw7+3mUWiNFOZppJLHJER_gNxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 10:12 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Oct 24, 2017 at 02:41:09PM +0800, Shawn Guo wrote:
>> > > +HiSilicon STB PCIE/SATA/USB3 PHY
>> > > +
>> > > +Properties:
>> > > +- compatible: Should be "hisilicon,hi3798cv200-combphy"
>> > > +- #phy-cells: Should be 1.  The cell number is used to select the phy mode:
>> > > + 0: PCIe mode
>> > > + 1: USB 3.0 mode
>> > > + 2: SATA mode
>> > > +- clocks: The phandle to clock provider and clock specifier pair.
>> > > +- resets: The phandle to reset controller and reset specifier pair.
>> > > +- hisilicon,peripheral-syscon: The phandle to the peripheral controller.
>> >
>> > Could just be a child of the syscon instead?
>>
>> It should be doable, but I do not fully understand the benefits of doing
>> that.
>
> Okay, I see that having it be child of syscon can save us this
> hisilicon,peripheral-syscon property, as the parent will just be the
> syscon device.  Also, if there is any register space only for phy
> device, we can define them as regular 'reg' property.

Yes, exactly.

Rob

From: josh.coombs@gmail.com (Josh Coombs)
Date: Tue, 19 Jun 2012 08:26:53 -0400
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
In-Reply-To: <20120619071854.GA28421@schnuecks.de>
References: <CAMW5UfaUBROU4o+1jz9O0AxTAgN6e0bjOX=T7YwQvomCTec3aQ@mail.gmail.com>
 <20120619071854.GA28421@schnuecks.de>
Message-ID: <CAMW5UfZf2eqOXeovdjLd+1TB6iGqndbj_U8BWFMPnXLY0YB4BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 3:18 AM, Simon Baatz <gmbnomis@gmail.com> wrote:
> Hi Josh,
>
> On Mon, Jun 18, 2012 at 08:35:27PM -0400, Josh Coombs wrote:
>> This is an attempt to get the Seagate GoFlex Net booting using
>> Kirkwood DTS support based on Arch Linux ARM's non-DTS GFN patches.
>> Currently 3.5rc3 will load and begin initializing, but stops without
>> error before mounting a rootfs and starting init. ?This patch is based
>> on 3.5rc3 with the printk fix already applied. ?The only oddity I can
>> pick out from dmesg is the console attaching to ttyS0 twice.
>
> It looks like you don't enable NAND (the GoFlex Net has NAND, isn't
> it?). The problem is that the associated clock (runit) seems also to
> be used for other purposes and the machine locks up when it is
> disabled if neither NAND nor SPI are used.
>
> Thus, you either need to find Andrew's patch (can't lookup the URL
> currently, the title is "Fix crash when neither NAND nor SPI") to
> always enable the clock or you should add a nand part to your dts
> file.

Initially I had the NAND layout defined in the DTS similar to
RaidSonic ICY BOX IB-NAS62x0, I removed it when I restarted my attempt
based strictly on the Dreamplug's implementation (which appears to
hang it's flash off SPI instead).  I'll re-add to the DTS and remove
the unused portion from the board file and see if that makes a
difference.  Thank you for the review, I should have results this
evening.

Josh C

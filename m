From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 14 Apr 2015 13:01:30 +0200
Subject: [PATCH v11]: clk: Add common clock support for Mediatek MT8135
 and MT8173
In-Reply-To: <20150414100810.GH4946@pengutronix.de>
References: <1427825817-26773-1-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeJ256HBLP+3WB+acNbMonGknQJgWBnGjEx1VWecWc-Y5g@mail.gmail.com>
 <20150414100810.GH4946@pengutronix.de>
Message-ID: <CABuKBeLxcCcfcunwX7q=hSHRrrHd5-EMgRzSwhx9eSdvNKum=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

2015-04-14 12:08 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> Hi Matthias,
>
> On Tue, Apr 07, 2015 at 01:47:58PM +0200, Matthias Brugger wrote:
>> Hi Sascha,
>>
>>
>> 2015-03-31 20:16 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
>> >
>> > The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:
>> >
>> >   Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.pengutronix.de/git/imx/linux-2.6.git tags/v4.0-clk-mediatek-v11
>> >
>> > for you to fetch changes up to ae9129219143cfdefe8b3a463deb8c5cb8955525:
>> >
>> >   dt-bindings: ARM: Mediatek: Document devicetree bindings for clock/reset controllers (2015-03-31 20:08:46 +0200)
>> >
>> > ----------------------------------------------------------------
>> > This patchset contains the initial common clock support for Mediatek SoCs.
>> > Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes
>> > and clock gates.
>>
>> I tried the patch set on my mt8135 eval board. I used the dts bindings
>> from a former version of this set [1], but it does not boot the board
>> (based on v4.0-rc7).
>> Do you have any hint, what is happening, or are the bindings wrong?
>
> I just tried on a v4.0 with
> - this series applied
> - the dts patch applied (which is still up-to-date)
> - multi_v7_defconfig
>
> And it still works. What do you mean with "does not boot the board"? No
> console output? Could you try with earlyprintk?

The probelms I see is, that with the clock patches, I'm not able to
boot into a initramfs [1].
Whereas if I just comment topckgen and preicfg in the dts, I'm able to
get the a serial console of my initramfs [2].

I wonder if you are able to get serial console from the initramfs with
the clock patches + dts patch?

Cheers,
Matthias

[1] http://pastebin.com/wmmsbdNp
[2] http://pastebin.com/jZHrxmmT

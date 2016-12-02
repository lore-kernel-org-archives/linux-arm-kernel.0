From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 3 Dec 2016 00:52:14 +0100
Subject: [PATCH v2 0/7] stmmac: dwmac-meson8b: configurable RGMII TX delay
In-Reply-To: <20161127.203324.1634866862730391239.davem@davemloft.net>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
 <20161127.203324.1634866862730391239.davem@davemloft.net>
Message-ID: <CAFBinCDHHT-eWoYmsVQyihcbrvoW=qP9MnG8hRfMfk4VRekS2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 2:33 AM, David Miller <davem@davemloft.net> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Date: Fri, 25 Nov 2016 14:01:49 +0100
>
>> Currently the dwmac-meson8b stmmac glue driver uses a hardcoded 1/4
>> cycle TX clock delay. This seems to work fine for many boards (for
>> example Odroid-C2 or Amlogic's reference boards) but there are some
>> others where TX traffic is simply broken.
>> There are probably multiple reasons why it's working on some boards
>> while it's broken on others:
>> - some of Amlogic's reference boards are using a Micrel PHY
>> - hardware circuit design
>> - maybe more...
>
> The ARM arch file changes do not apply cleanly to net-next, you probably
> want to merge them via the ARM tree instead of mine, and respin this series
> to be without the .dts file changes.
done, v3 contains only the net-next changes while the dts changes can
be found here: [0]


Regards,
Martin


[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-December/001836.html

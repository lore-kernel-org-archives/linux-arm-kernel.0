From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 6 Aug 2013 08:03:21 +0800
Subject: [alsa-devel] [PATCH 2/3] ASoC: hdmi-codec: enable OF support
In-Reply-To: <20130717095708.GG22506@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
 <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
 <20130717095708.GG22506@sirena.org.uk>
Message-ID: <CAGsJ_4ydsiEjYnP7YXGHWK0CDEfHgi9N12gw=bzQZU_2_fEA4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/17 Mark Brown <broonie@kernel.org>:
> On Wed, Jul 17, 2013 at 09:49:10AM +0100, Mark Rutland wrote:
>> On Wed, Jul 17, 2013 at 07:12:15AM +0100, Barry Song wrote:
>
>> > this makes users be able to add a hdmi-codec node in dts instead of
>> > hardcoding a platform device in mach.
>
>> Similarly to my comment on the first patch, I'm not sure this is the
>> best way to wire this up to devicetree. Can this not be hung off of hdmi
>> controller drivers?
>
> This one is different to the BT case - as you say it's hanging off the
> HDMI controller so the HDMI controller ought to enumerate it either as a
> stub or by actually seeing a device.  The platform device is fine but
> it's not something that should appear in the DT unless it's conveying
> some information about what's connected there (eg, power supplies for
> something soldered down on the board).

it should be ok that the platform_device is allocated and added in the
HDMI controller codes.

-barry

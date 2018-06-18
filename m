From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 18 Jun 2018 10:11:20 +0800
Subject: [PATCH v3 0/4] allwinner: a64: add SRAM controller / system
 control
In-Reply-To: <20180615091413.pbdtrpa7txe6i4ee@flea>
References: <20180614153548.9644-1-wens@csie.org>
 <20180615091413.pbdtrpa7txe6i4ee@flea>
Message-ID: <CAGb2v64Ar+rOgiXbjtRrQojHUZteLa9N7OwM3XY7ZcpS87Qpmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 5:14 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Thu, Jun 14, 2018 at 11:35:44PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> This series is the remaining A64 syscon changes from the R40 DWMAC
>> series. The series aligns how the A64 system control exports a regmap
>> for the sun8i DWMAC driver to access with what we've done for the R40.
>>
>> Originally the A64 used the generic syscon for this bit of hardware.
>> But this block also contains mapping bits for the onboard SRAM, used
>> by various peripherals, and other vendor specific bits we may use in
>> the future. It is by no means generic. And we already have a device
>> tree binding and driver for the SRAM part.
>>
>> The first patch make the SRAM control device export a regmap, exposing
>> a single EMAC control register, for the DWMAC driver to consume.
>>
>> The second and third patches rename the A64 compatible string to read
>> "system control", which is what the block is named in the user manual.
>>
>> The last patch fixes up the device node, and also adds the lone mappable
>> SRAM block, which is needed by the Display Engine.
>
> For the serie:
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Cool. I'll apply them once you've rebased and pushed out any patches you
queued up during the merge window.

ChenYu

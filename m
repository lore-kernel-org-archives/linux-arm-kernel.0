From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Aug 2017 16:56:25 +0200
Subject: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <2578d94a-fd1b-9598-251d-59764a870933@baylibre.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
 <2578d94a-fd1b-9598-251d-59764a870933@baylibre.com>
Message-ID: <CAK8P3a20dXeeNkRCgs8BNWOo1zvNpBLqkQNwpj8dS2bOq1cq+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 4:30 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 08/02/2017 03:18 PM, Oleksandr Shamray wrote:
>> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.

>> +static u32 aspeed_jtag_read(struct aspeed_jtag *aspeed_jtag, u32 reg)
>> +{
>> +     return readl(aspeed_jtag->reg_base + reg);
>> +}
>> +
>> +static void
>> +aspeed_jtag_write(struct aspeed_jtag *aspeed_jtag, u32 val, u32 reg)
>> +{
>> +     writel(val, aspeed_jtag->reg_base + reg);
>> +}
>
> Maybe readl_relaxed/writel_relaxed would be enough here.

I'd prefer keeping the regular accessors here, unless this is shown
to be a performance bottleneck, and there is a comment to explain
how the relaxed accessors are determined to be safe.

        Arnd

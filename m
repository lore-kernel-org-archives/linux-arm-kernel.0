From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 21:58:26 +0200
Subject: [PATCH] arm64: sunxi: always enable reset controller
In-Reply-To: <20170420080241.4445eir3nsmrq6fw@lukather>
References: <20170419173601.3773999-1-arnd@arndb.de>
 <20170420080241.4445eir3nsmrq6fw@lukather>
Message-ID: <CAK8P3a0x5Jh4wby_v2Etq1iEpVns=fEniM2qPj3wkKLn-YtSDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 10:02 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Apr 19, 2017 at 07:35:36PM +0200, Arnd Bergmann wrote:
>> The sunxi clk driver causes a link error when the reset controller
>> subsystem is disabled:
>>
>> drivers/clk/built-in.o: In function `sun4i_ve_clk_setup':
>> :(.init.text+0xd040): undefined reference to `reset_controller_register'
>> drivers/clk/built-in.o: In function `sun4i_a10_display_init':
>> :(.init.text+0xe5e0): undefined reference to `reset_controller_register'
>> drivers/clk/built-in.o: In function `sunxi_usb_clk_setup':
>> :(.init.text+0x10074): undefined reference to `reset_controller_register'
>>
>> We already force it to be enabled on arm32 and some other arm64 platforms,
>> but not on arm64/sunxi. This adds the respective Kconfig statements to
>> also select it here.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm64/Kconfig.platforms | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> I'd suggest we can pick this up in arm-soc as a non-urgent bugfix for 4.12
>
> That works for me, you can add my Acked-by.
>

Applied now.

        Arnd

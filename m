From: cjb@laptop.org (Chris Ball)
Date: Thu, 26 Sep 2013 07:57:43 -0400
Subject: [PATCH v2 0/9] mmc: sdhci-esdhc-imx: add SD3.0 support
In-Reply-To: <20130926090158.GC21081@S2101-09.ap.freescale.net> (Shawn Guo's
 message of "Thu, 26 Sep 2013 17:02:00 +0800")
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
 <87siws2ve7.fsf@octavius.laptop.org>
 <20130926090158.GC21081@S2101-09.ap.freescale.net>
Message-ID: <87siwrre14.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 26 2013, Shawn Guo wrote:
> On Wed, Sep 25, 2013 at 10:01:52PM -0400, Chris Ball wrote:
>> Hi Shawn, Sascha,
>> 
>> On Fri, Sep 13 2013, Dong Aisheng wrote:
>> > This patch series add SD3.0 support for i.MX6Q/DL.
>> > Since freescale i.MX6Q/DL uSDHC clock tuning progress is a little
>> > different from
>> > the standard tuning process defined in host controller spec v3.0.
>> > So we add a hook to allow execute platform specific tuning instead of
>> > standard host controller tuning.
>> >
>> > The main difference are:
>> > 1) not only generate Buffer Read Ready interrupt when tuning is performing.
>> > It generates all other DATA interrupts like the normal data command.
>> > 2) SDHCI_CTRL_EXEC_TUNING is not automatically cleared by HW,
>> > instead it's controlled by SW.
>> > 3) SDHCI_CTRL_TUNED_CLK is not automatically set by HW,
>> > it's controlled by SW.
>> > 4) the clock delay for every tuning is set by SW.
>> >
>> > Tested on i.MX6Q Sabreauto board.
>> 
>> Please could someone ACK this series?  Thanks,
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> One thing need to mention is that the series only adds support for
> UHS SDR cards, and DDR cards haven't been working yet.

Thanks, patches 1-8 pushed to mmc-next for 3.13 with Shawn's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

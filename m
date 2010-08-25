From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 25 Aug 2010 21:20:15 +0800
Subject: [PATCH 2/3] [ARM] pxa: MFU pin configuration to support Fast
	ethernet.
In-Reply-To: <201008251511.02665.marek.vasut@gmail.com>
References: <1282727921.6968.99.camel@pe-lt522.marvell.com>
	<201008251511.02665.marek.vasut@gmail.com>
Message-ID: <AANLkTinzvaHvOXPP=Nr79OBB_8DdNum3MjMJnLzzTBg0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 9:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne St 25. srpna 2010 11:18:41 Sachin Sanap napsal(a):
>> Signed-off-by: Sachin Sanap <ssanap@marvell.com>
>> ---
>> ?arch/arm/mach-mmp/aspenite.c ? ? ? ? ? ? ? ?| ? 18 ++++++++++++++++++
>> ?arch/arm/mach-mmp/include/mach/mfp-pxa168.h | ? 19 +++++++++++++++++++
>> ?2 files changed, 37 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
>> index d19c26c..a235551 100644
>> --- a/arch/arm/mach-mmp/aspenite.c
>> +++ b/arch/arm/mach-mmp/aspenite.c
>> @@ -74,6 +74,24 @@ static unsigned long common_pin_config[] __initdata = {
>> ? ? ? GPIO105_CI2C_SDA,
>> ? ? ? GPIO106_CI2C_SCL,
>>
>> + ? ? /* MFU */
>> + ? ? GPIO86_TX_CLK,
>> + ? ? GPIO87_TX_EN,
>> + ? ? GPIO88_TX_DQ3,
>> + ? ? GPIO89_TX_DQ2,
>> + ? ? GPIO90_TX_DQ1,
>> + ? ? GPIO91_TX_DQ0,
>> + ? ? GPIO92_MII_CRS,
>> + ? ? GPIO93_MII_COL,
>> + ? ? GPIO94_RX_CLK,
>> + ? ? GPIO95_RX_ER,
>> + ? ? GPIO96_RX_DQ3,
>> + ? ? GPIO97_RX_DQ2,
>> + ? ? GPIO98_RX_DQ1,
>> + ? ? GPIO99_RX_DQ0,
>> + ? ? GPIO100_MII_MDC,
>> + ? ? GPIO101_MII_MDIO,
>> + ? ? GPIO103_RX_DV,
>> ?};
>>
>
> That's for ethernet, right ? Can you take aspenite apart (aka. remove the
> ethernet chip or whatnot) ?
>
> Maybe if you'd go the way I outlined in the previous mail commenting on your 1/3
> patch and apply that approach on the whole aspenite, then there's a space for
> further improvement. That is, split the MFP config structure into smaller chunks
> and configure the pins only in case that particular device is enabled in kernel.
> See colibri_pxa320 for reference again.
>

Well, if it's not separable, and that those pins are not able to be used
as other functions, I'd prefer this being in one consistent array actually.

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Oct 2010 15:04:35 +0200
Subject: [PATCH 1/3] imx-esdhc: update devices registration
In-Reply-To: <4CB45B4A.5090003@eukrea.com>
References: <1286886237-29014-1-git-send-email-eric@eukrea.com>
	<20101012123312.GK29673@pengutronix.de>
	<4CB45B4A.5090003@eukrea.com>
Message-ID: <20101012130435.GN29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Eric,
On Tue, Oct 12, 2010 at 02:57:46PM +0200, Eric B?nard wrote:
> Hi Uwe,
>
> Le 12/10/2010 14:33, Uwe Kleine-K?nig a ?crit :
>>> +#ifdef CONFIG_ARCH_MX51
>>> +const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
>>> +#define imx51_esdhc_data_entry(_id, _hwid)				\
>>> +	imx_esdhc_imx_data_entry(MX51, MMC_SDHC, "sdhci-esdhc-imx", _id, _hwid, SZ_16K)
>>> +	imx51_esdhc_data_entry(0, 1),
>>> +	imx51_esdhc_data_entry(1, 2),
>>> +	imx51_esdhc_data_entry(2, 3),
>>> +	imx51_esdhc_data_entry(3, 4),
>>> +};
>>> +#endif /* ifdef CONFIG_ARCH_MX51 */
>> Hmmm, I think it's sensible to use the config struct only for data that
>> is actually different for the different socs.  That is MMC_SDHC,
>> "sdhci-esdhc-imx" and SZ_16K doesn't need to be part of the data.
>>
> keeping it like this will allow to handle the case of future i.MX socs  
> which may need special (like for spi for example) for new revisions of  
> the esdhc IP.
OK, the "danger" is real as we're talking about Freescale here.  Still I
think if that happens we only have to touch a single file and so I
prefer to have it as simple as possible as long as possible.

>>> +#define MX51_SSI3_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe8000)
>> This is unrelated, no?
>>
> fixed in V2.
Yep, just saw that after I hit the send button :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

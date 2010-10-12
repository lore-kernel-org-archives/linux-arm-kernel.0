From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 12 Oct 2010 14:57:46 +0200
Subject: [PATCH 1/3] imx-esdhc: update devices registration
In-Reply-To: <20101012123312.GK29673@pengutronix.de>
References: <1286886237-29014-1-git-send-email-eric@eukrea.com>
	<20101012123312.GK29673@pengutronix.de>
Message-ID: <4CB45B4A.5090003@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 12/10/2010 14:33, Uwe Kleine-K?nig a ?crit :
>> +#ifdef CONFIG_ARCH_MX51
>> +const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
>> +#define imx51_esdhc_data_entry(_id, _hwid)				\
>> +	imx_esdhc_imx_data_entry(MX51, MMC_SDHC, "sdhci-esdhc-imx", _id, _hwid, SZ_16K)
>> +	imx51_esdhc_data_entry(0, 1),
>> +	imx51_esdhc_data_entry(1, 2),
>> +	imx51_esdhc_data_entry(2, 3),
>> +	imx51_esdhc_data_entry(3, 4),
>> +};
>> +#endif /* ifdef CONFIG_ARCH_MX51 */
> Hmmm, I think it's sensible to use the config struct only for data that
> is actually different for the different socs.  That is MMC_SDHC,
> "sdhci-esdhc-imx" and SZ_16K doesn't need to be part of the data.
>
keeping it like this will allow to handle the case of future i.MX socs 
which may need special (like for spi for example) for new revisions of 
the esdhc IP.

>> +#define MX51_SSI3_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe8000)
> This is unrelated, no?
>
fixed in V2.

Eric

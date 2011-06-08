From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 8 Jun 2011 14:08:33 +0800
Subject: [PATCH v2 1/3] mmc: support sdhci-mmp2
In-Reply-To: <6B2AC372-8A17-41B9-AA5F-BBE5189D17C4@marvell.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
	<BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
	<6B2AC372-8A17-41B9-AA5F-BBE5189D17C4@marvell.com>
Message-ID: <BANLkTi=DOHLt1uv-Oz=qnQCE-qmNAVahcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> This method is used in v1,
>> The method makes sdhci_ops non-const and have to dynamically alloc
>> sdhci_ops, since host->ops is pointer.
>> Will keep use const sdhci_ops, recommended by Arnd.
>
>
> Not acceptable.
>
>
> There are ?3 cases for ?WP signal
>
> a) They are connected to the controller using GPIO
> b( They are NOT connected and the corresponding ?pin is not used
> c) They are NOT connected and the corresponding ?pin is used by something else.
>
> case a)
> ? ? ? ?program GPIO as is done today in brownstone and aspen
>
> case b)
> ? ? ? ?configure the MFP pin to be pull high/low to indicate NO WP. ?The pin cannot be left floating

Thanks, configure WP pin to LOW should be work for micro sd card.
>
> case c)
> ? ? ? ?you need a quirk and the call back.
>
>
>
>
>
>

From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 22 Oct 2010 09:07:58 +0200
Subject: [PATCH 2/2] sdhci-esdhc-imx: enable QUIRK_NO_MULTIBLOCK only
	for i.MX25 and i.MX35
In-Reply-To: <20101022061803.GB5572@pengutronix.de>
References: <4CC0A281.1010202@eukrea.com>
	<1287696028-27854-2-git-send-email-eric@eukrea.com>
	<20101022061803.GB5572@pengutronix.de>
Message-ID: <4CC1384E.4000403@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le 22/10/2010 08:18, Wolfram Sang a ?crit :
> On Thu, Oct 21, 2010 at 11:20:28PM +0200, Eric B?nard wrote:
>> only these CPU's errata list this bug.
>
> So, it was not directly tested?
>
While I was testing the other quirk, I tested this one on 25, 35 & 51, but I 
can't trigger the bug on any of these CPU (without the quirk : the bug suppose 
there is an error reading one block and that the MMC layer then sends CMD12 
which can't stop the AHB transfer and thus the controler stays blocked. As I 
didn't met an error to read a block, I wasn't able to trigger the bug.

Eric

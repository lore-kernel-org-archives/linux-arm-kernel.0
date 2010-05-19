From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 19 May 2010 19:21:09 +0200
Subject: [PATCH 09/13] mxcmmc: add card detect through DAT3 possibility
In-Reply-To: <20100519171141.GW30801@buzzloop.caiaq.de>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
	<1274287568-30253-8-git-send-email-eric@eukrea.com>
	<1274287568-30253-9-git-send-email-eric@eukrea.com>
	<20100519171141.GW30801@buzzloop.caiaq.de>
Message-ID: <4BF41E05.3050107@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/05/2010 19:11, Daniel Mack a ?crit :
>> +	if (host->pdata &&  host->pdata->dat3_card_detect)
>
> As 0 is a valid GPIO, so you should use gpio_is_valid() here, and update
> all users' pdata to set dat3_card_detect = -1, so it will fail this
> test.
>
dat3_card_detect is not a GPIO number, it's just a flag to indicate that 
we want to use the internal detection feature provided by the mxcmci on 
DAT3 gpio (which is not used in GPIO mux).

Eric

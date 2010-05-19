From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 19 May 2010 19:23:57 +0200
Subject: [PATCH 09/13] mxcmmc: add card detect through DAT3 possibility
In-Reply-To: <4BF41E05.3050107@eukrea.com>
References: <1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
	<1274287568-30253-8-git-send-email-eric@eukrea.com>
	<1274287568-30253-9-git-send-email-eric@eukrea.com>
	<20100519171141.GW30801@buzzloop.caiaq.de>
	<4BF41E05.3050107@eukrea.com>
Message-ID: <20100519172357.GX30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 07:21:09PM +0200, Eric B?nard wrote:
> Le 19/05/2010 19:11, Daniel Mack a ?crit :
> >>+	if (host->pdata &&  host->pdata->dat3_card_detect)
> >
> >As 0 is a valid GPIO, so you should use gpio_is_valid() here, and update
> >all users' pdata to set dat3_card_detect = -1, so it will fail this
> >test.
> >
> dat3_card_detect is not a GPIO number, it's just a flag to indicate
> that we want to use the internal detection feature provided by the
> mxcmci on DAT3 gpio (which is not used in GPIO mux).

I'm sorry. I should have had a closer look. Ignore me :)

Daniel

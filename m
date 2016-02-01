From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 11:28:39 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: Fix double enabling of regulators
In-Reply-To: <CAGS+omD=ZdLoT8fZ_vq4CvdCvAwsz2tbdEzS5Q8pAL5zAKW5yA@mail.gmail.com>
References: <1453466365-24406-1-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omD=ZdLoT8fZ_vq4CvdCvAwsz2tbdEzS5Q8pAL5zAKW5yA@mail.gmail.com>
Message-ID: <56AF3357.1040707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/01/16 20:26, Daniel Kurtz wrote:
> On Fri, Jan 22, 2016 at 4:39 AM, Sascha Hauer<s.hauer@pengutronix.de>  wrote:
>> >
>> >With CONFIG_PM enabled do not call genpd->power_on manually as this
>> >will cause the regulators being turned on once in SCPSYS probe and
>> >then again when the genpd core turns on the domains. Instead, call
>> >genpd->power_on only with CONFIG_PM disabled and tell the genpd core
>> >that the domains are disabled when registered.
>> >
>> >Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
> Take your pick:
> Tested-by: Daniel Kurtz<djkurtz@chromium.org>
> Reviewed-by: Daniel Kurtz<djkurtz@chromium.org>
>
>> >---

Applied, thanks.

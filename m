From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 30 Mar 2011 18:46:17 +0200
Subject: [PATCH] mmc: change CONFIG of MMC_SDHCI based drivers from 'bool'
	to 'tristate'
In-Reply-To: <m37hbihenx.fsf@pullcord.laptop.org>
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>	<20110328143806.GC18721@S2100-06.ap.freescale.net>
	<m37hbihenx.fsf@pullcord.laptop.org>
Message-ID: <4D935E59.2020908@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 03:57 AM, Chris Ball wrote:
> Hi Shawn,
> 
> On Mon, Mar 28 2011, Shawn Guo wrote:
>> Hi Chris,
>>
>> Any comment on this one?
> 
> Yep, I'll push it to mmc-next once -rc1 is released.
> 
> Thanks,
> 
> - Chris.

That patch doesn't make much sense. The config options are used to decide
whether support for that platform should be build into the sdhci-platform or
sdhci-of module. So setting them 'm' doesn't make any sense, since you can't
build part of an module as a module. The effect for 'm' will probably be the
same as for 'n'.

- Lars

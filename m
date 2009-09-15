From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 20:21:05 +0900
Subject: [PATCH 08/10] S3C64XX I2S: Return correct codec clock
In-Reply-To: <20090915110635.GI22878@rakim.wolfsonmicro.main>
References: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
	<20090915110635.GI22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150421y7c78ad8dt2703bd039fcd39b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 8:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 07:02:40PM +0900, Jassi wrote:
>
>> - ? ? return i2s->iis_cclk;
>> + ? ? if(iismod & S3C64XX_IISMOD_IMS_SYSMUX)
>> + ? ? ? ? ? ? return i2s->iis_cclk;
>> + ? ? else
>> + ? ? ? ? ? ? return i2s->iis_pclk;
>
> There's three possible clocks here according to the datasheet - PCLK,
> CLKAUDIO and I2SCLK - so this will still give the wrong clock some of
> the time. ?Also, please use checkpatch
Yes, but the existing code doesn't consider I2SCLK at all.
The infra isn't there to provide the clock pointer anyhow.
Will use checkpatch, thanks.

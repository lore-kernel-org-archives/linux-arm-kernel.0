From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 01 Aug 2012 08:19:28 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <20120731151819.GC4468@opensource.wolfsonmicro.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
Message-ID: <5018D880.5090306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 16:18, Mark Brown wrote:
>>> It's certainly totally inappropriate for an "urgent" bugfix.
>
>> Well it just means that audio won't work for the ux500 for this
>> kernel release, but as we're waiting on clocks, this isn't a big
>> issue for us. If you do take it (with or without the return code),
>> feel free to add it to for-next instead of the -rc:s
>
> I'm not going to apply this patch.  This isn't a vendor BSP, we
> shouldn't be putting random hacks like this in core code.

BSP kernel or otherwise, it still seems wrong to me to fail and entire 
audio driver just because of a broken link.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

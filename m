From: kishorek.kadiyala@gmail.com (kishore kadiyala)
Date: Thu, 12 Aug 2010 01:39:38 +0530
Subject: [PATCH v3 9/9] omap: zoom: add mmc3/wl1271 device support
In-Reply-To: <AANLkTik8yftwy9Toq473134vcdoFN1Z29oTc9MGEUzue@mail.gmail.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-10-git-send-email-ohad@wizery.com>
	<4C626140.3080107@nokia.com>
	<AANLkTik8yftwy9Toq473134vcdoFN1Z29oTc9MGEUzue@mail.gmail.com>
Message-ID: <AANLkTi=n=uH5ePRf8KzXWTtSdyRabpOCOgLBSD1GfwkJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad,

On Wed, Aug 11, 2010 at 9:08 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Aug 11, 2010 at 11:37 AM, Roger Quadros <roger.quadros@nokia.com> wrote:
>>> + ? ? ? ? ? ? ? .ocr_mask ? ? ? = MMC_VDD_165_195,
>>
>> Do we really need to specify ocr_mask here?

Since you specified the voltage source is fixed, and if MMC3 has any
dedicated regulator as MMC1 & MMC2 you can go with
Roger's comments.
If the LDO is fixed voltage source from TWL then since regulator
framework supports only adjustable LDO's, I think you can
have ocr_mask defined as above in board file.

Regards,
Kishore
>
> Removed, thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

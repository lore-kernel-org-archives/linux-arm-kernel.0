From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 14 Dec 2012 16:52:30 +0100
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the
 driver
In-Reply-To: <20121214151002.GK14363@n2100.arm.linux.org.uk>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20121214151002.GK14363@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFogripZun48OFL4RfGh+sJD4037+kZe068CM86O8jhVYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, 14 December 2012, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:
> On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
>> From: Lee Jones <lee.jones@linaro.org>
>>
>> There are currently two instances of the ios_handler being used.
>> Both of which mearly toy with some regulator settings. Now there
>> is a GPIO regulator API, we can use that instead, and lessen the
>> per platform burden. By doing this, we also become more Device
>> Tree compatible.
>
> Err, why is this needed?  What's wrong with using the 'vmmc' for this?

This is not for power to the card, but for the I/O voltage. Before this was
controlled by the ios_handler.

>
> From what I read in the mmc core, vmmc handling via
mmc_regulator_set_ocr()
> can cope with GPIO-based regulators, and if you have a single GPIO signal
> then you have a single supply (it's either on or off).  So what's wrong
> with using the existing regulator hooks for this which are already there?

Kind regards
Ulf Hansson

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/abf80c4c/attachment-0001.html>

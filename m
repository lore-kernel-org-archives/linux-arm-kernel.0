From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 2 Aug 2013 16:55:20 +0200
Subject: [PATCH v7] watchdog: Add MOXA ART watchdog driver
In-Reply-To: <20130802114159.GK2884@e106331-lin.cambridge.arm.com>
References: <1375098093-8975-1-git-send-email-jonas.jensen@gmail.com>
 <1375101228-10930-1-git-send-email-jonas.jensen@gmail.com>
 <20130802114159.GK2884@e106331-lin.cambridge.arm.com>
Message-ID: <CACmBeS3M+3Bah849N9jC6TFft4SN=ZhZfUh=65zf5Lf2d+VoQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the replies.

On 2 August 2013 13:41, Mark Rutland <mark.rutland@arm.com> wrote:
> It would be nice to have a fuller description here.

I have tried to elaborate the commit message, please point out if it
should be formatted differently.

>> +Example:
>> +
>> +     watchdog: watchdog at 98500000 {
>> +             compatible = "moxa,moxart-watchdog";
>> +             reg = <0x98500000 0x10>;
>> +             clocks = <&coreclk>;
>> +     };
>
> This seems sensible to me. I assume the watchdog is a standalone unit,
> and not part of some larger piece of IP?

I think it's standalone, unfortunately documentation on the SoC (which
this is likely part of) is not publicly available.

The register is not shared with anything else.

> This is a probe path. Is the use of unlikely() really appropriate here?
> I suspect it doesn't make any appreciable difference, and should go.

No, it just happened to get copied from a reference driver.

Best regards,
Jonas

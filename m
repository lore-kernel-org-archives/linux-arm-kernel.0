From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 26 Feb 2015 11:05:25 -0800
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <A5AB3F5F-7942-4DA0-925E-9033EC929174@codeaurora.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <A5AB3F5F-7942-4DA0-925E-9033EC929174@codeaurora.org>
Message-ID: <CAJAp7Og+2kuSY=NJoJKH9frS7+QjLUjrexxK1-S3Dfd6p8EFfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 10:25 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Feb 23, 2015, at 1:54 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> This patch adds rpm node to apq8064 dt as rpm would be used by other
>> devices for regulator support. Also adds all the regulators in the rpm.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[..]
>> +                     interrupts      = <0 19 0>, <0 21 0>, <0 22 0>;
>> +                     interrupt-names = "ack", "err", "wakeup";
>> +
>
> Can you use the defines for GIC for the interrupts.  Also, I think the last property should probably be level high instead of 0.
>

The code sets it to rising, but better move that to the dt (as you suggest).

Regards,
Bjorn

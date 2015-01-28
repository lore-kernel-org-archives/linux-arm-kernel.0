From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 27 Jan 2015 21:36:38 -0600
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <20150128015131.22722.22882@quantum>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
 <CAHrpEqQ-eoqM3W1hYcS6EPTmur1FSfm8TeEjYrtZ+PquavL86w@mail.gmail.com>
 <201501220039.02073.marex@denx.de>
 <20150128015131.22722.22882@quantum>
Message-ID: <CAHrpEqSFfdWsCif_wZO2ToRpwOuC2yt45+HwOpGgv+B=EwKTCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 7:51 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Marek Vasut (2015-01-21 15:39:01)
>> On Wednesday, January 21, 2015 at 05:16:03 PM, Zhi Li wrote:
>> > On Sun, Dec 28, 2014 at 4:26 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> > > According to i.MX23 and i.MX28 reference manual the fractional
>> > > clock control registers must be addressed by byte instructions.
>> >
>> > I don't think mx23 and mx28 have such limitation. I will double check
>> > with IC team about this.
>> > RTL is generated from a xml file. All registers implement is unified.
>> > I don't think only clock control register have such limitation and
>> > other registers not.
>>
>> Hi,
>>
>> Section 10.8.24 in the MX28 datasheet (Fractional Clock Control Register 0)
>> states otherwise, but maybe the documentation is simply not matching the
>> silicon.
>>
>> Here's a quote:
>> "
>> This register controls the 9-phase fractional clock dividers. The fractional
>> clock frequencies are a product of the values in these registers. NOTE: This
>> register can only be addressed by byte instructions. Addressing word or half-
>> word are not allowed.
>> "
>>
>> I also recall seeing weird behavior when these registers were accessed by word
>> access in U-Boot, so I believe the datasheet is correct.
>
> Hi Frank,
>
> Are you satisfied with this patch?

I asked IC designer about this.
They will check RTL code.
I will check their status again.
Our released BSP code used 32bit WORD access.

best regards
Frank Li
>
> Regards,
> Mike
>
>>
>> Best regards,
>> Marek Vasut

From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 14 May 2013 22:01:18 +0100
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <20130514165937.10068.18501@quantum>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <20130513195746.10068.92303@quantum>
 <CAAG0J991BCziPFddzBrx9vcwRxyRgcCd38A01uKXTDDK9xTnbQ@mail.gmail.com>
 <20130514165937.10068.18501@quantum>
Message-ID: <5192A61E.5020605@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 14/05/13 17:59, Mike Turquette wrote:
> Quoting James Hogan (2013-05-13 14:30:46)
>> On 13 May 2013 20:57, Mike Turquette <mturquette@linaro.org> wrote:
>>> One reason for this is the difficulty some have had with setting flags
>>> from DT bindings.
>>
>> Could you elaborate on this? I've been adding flags to DT bindings for
>> this sort of thing, but it feels a bit like it's in that grey area of
>> not really describing the hardware itself. This information needs to
>> be specified somehow though.
>>
> 
> It depends on the flag.  A good example is the CLK_DIVIDER_ONE_BASED
> flag which does describe the hardware.  It informs the binding that
> indexing starts at 1, not 0, which is a valid part of the hardware
> description.
> 
> However flags that deal with software policy do not belong on DT.
> CLK_SET_RATE_PARENT certainly does not belong in the DT binding since
> this is a pure Linux-ism.  Every binding just needs to be reviewed on a
> case-by-case basis to make sure the flags are related only to the
> hardware.

So given the desire to eliminate platform code, is there a particular
way that these other flags can be specified instead of DT bindings?

Cheers
James

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 14:19:50 +0100
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
In-Reply-To: <20180129005129.GB12728@builder>
References: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
 <20180128232310.GA12728@builder>
 <042b6cea-38f7-a660-0059-5f24fc7db9eb@codeaurora.org>
 <20180129005129.GB12728@builder>
Message-ID: <CACRpkdaa0Ovb0kbE6J0vy4UJYv5fn6X2289pkX3b+HBze5FRJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 1:51 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

>> > My bad, this should have been -1.
>>
>> Perhaps, but it's been 0 for a very long time, so I don't want to break any
>> existing platforms by suddenly relocating all GPIOs across all Qualcomm
>> platforms.
>>
>
> Yeah, I see that I got this wrong when I wrote the driver 4 years ago...
>
> There should be no in-kernel users depending on these numbers being hard
> coded, so anyone depending on these numbers starting at 0 would be user
> space - doing so incorrectly.

There is a good point in what Tmur is saying here. We never break
userspace, if we can avoid it.

If there is a real problem with setting this base to -1 then I suggest

if (tlmm_has_only_one_instance)
   base = 0;
else
   base = -1;

Especially for an upcoming platform we can start with a clean slate,
it certainly does not have any legacy userspace.

If no problems are detected, let's just use -1.

Yours,
Linus Walleij

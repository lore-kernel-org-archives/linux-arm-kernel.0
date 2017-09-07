From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Wed, 6 Sep 2017 18:45:22 -0700
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <20170822160703.nusf7sv6k4gj3pti@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
 <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
 <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
 <20170822160703.nusf7sv6k4gj3pti@sirena.org.uk>
Message-ID: <492cb202-f4cb-4f5d-5d32-3dee4f1226b5@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/22/2017 9:07 AM, Mark Brown wrote:
> On Wed, Aug 16, 2017 at 12:39:42PM -0700, Lori Hikichi wrote:
>
>> By far the most common usage case for Cygnus is a configuration which
>> uses only the three i2s/tdm ports. In this case each port is assigned
>> a clock.  Each clock has the same capabilities so there would never be
>> a reason change the static mapping.
> The usual reason would be to bring things into sync.
>
>> Now for the case when the "non-audio block" uses one of these clocks.
>> In this situation we will only need one i2s port because this
>> configuration of the chip is not audio intensive.  When the system
>> is designed we know if this non-audio block will be in use, it is not
>> a runtime configurable thing. Again, a static mapping is fine.
> Is this limitation when the other block is in use a physical limitation
> or is it just a case of not seeing the use case.
>
>> At the time it did not seem necessary to make addition driver changes to
>> support a use case that will very likely never arise. As it turns out,
>> we are working on a new version of this audio block.  The clocking
>> configuration for this new version is more complex and I am already in
>> the process of creating clock bindings for all this this. I am hopeful
>> that the driver for this new version will be applicable to Cygnus.
> If the clocking is more complex that seems like even more reason to not
> fix this in the binding, and possibly to do as I think I suggested
> earlier and use the common clock bindings to manage this rather than
> doing something custom and driver specific.
Ok, I will create the necessary clocks to allow this to work.
This will likely impact a couple of the other patches in the series, but
most should be applicable. What would be the best way to have some of the
other patches in this series reviewed?  Should I just drop this series and
resubmit new individual patches for review.

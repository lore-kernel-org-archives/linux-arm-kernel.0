From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 09 Dec 2014 15:14:28 +0100
Subject: [PATCH v3 0/3] Add support for Tegra Activity Monitor
In-Reply-To: <CAAVeFuJkpuWocEDTfSAK7_UfhZvqOfYJY6sLgsy9i+KcMAkbCQ@mail.gmail.com>
References: <1417709696-29281-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAAVeFuJkpuWocEDTfSAK7_UfhZvqOfYJY6sLgsy9i+KcMAkbCQ@mail.gmail.com>
Message-ID: <548703C4.1030300@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2014 06:38 AM, Alexandre Courbot wrote:
> On Fri, Dec 5, 2014 at 1:14 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Hello,
>>
>> this v3 addresses the comments that the devfreq implementation got, namely:
>>
>> * Address misc. style issues found by Thierry and Alexander
>> * Added helpers for register i/o
>> * Further documented the structs
>> * Enable the ACTMON after the IRQ handler has been installed
>> * Disable the ACTMON before removing the IRQ handler
>> * Add governor in a subsys initcall
>>
>> There's an open question on whether some functionality currently in this
>> devfreq driver should be moved into the devfreq framework, but without knowing
>> of other SoC family that would benefit from it, I'm reticent. It would be
>> great to hear from the devfreq maintainers if they have any plans regarding
>> this, or if they have any suggestion.
> 
> I cannot make a thorough review because of the problem I mentioned in
> patch 3/3, but I am guessing this series is converging towards what we
> want. Now the main question will be how we can leverage Arto's
> watermark series for this one. I am ready to bet that doing so can
> reduce quite a lot of code.
> 
> Since you are likely to be the first user of the watermarking feature,
> could you comment on its potential shortcomings and whatever needs to
> be fixed to best implement ACTMON support using it? I will try to push
> it myself, but you are obviously in a better position to understand
> what is needed.

Sure, I'm still playing with the idea, but I have sent a few questions
to that thread already.

Cheers,

Tomeu

> Thanks!
> 

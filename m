From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 13 Jul 2017 17:46:04 +0800
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <20170713050934.GB352@vireshk-i7>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
 <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
 <CAGb2v67XtUcqdjMt-Ln6zn3ShH4JFmjkK4bPSpUNZpJqnmwivw@mail.gmail.com>
 <20170713050934.GB352@vireshk-i7>
Message-ID: <CAGb2v67pjFRTq56DE+2xCnnKhxa_1u6RdoxbwXznkg6EJ3=X9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 1:09 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13-07-17, 10:52, Chen-Yu Tsai wrote:
>> I'm afraid the regulator case still doesn't make sense. The voltage
>> constraints should be set within each supplies device node. This was
>> explained in the discussion in v1 [1].
>
> I thought we were discussing about something I mentioned in one of my example
> but never to a point that the regulator problem doesn't exist at all. Perhaps I
> misunderstood your concerns. Anyway, lemme try once more with a better example.
>
> Regulator shared by: LCD and MMC (both can do DVFS) and the min/max constraint
> that can be set by the consumers of the regulator (both LCD/MMC) are: 1.5 V to
> 3 V.
>
> The bootloader has programmed the LCD to work at the highest pixel frequency,
> which needs the voltage to be in range from 2.5 - 3 V.
>
> Now MMC can get probed first and it can try to bring the voltages below 2.5 V.
> Though, 1.5 - 2.5 is a valid range for the LCD, but not at the current pixel
> frequency.
>
> Does that sound like a valid problem?

This makes more sense. The LCD being able to do DVFS was missing from the last
discussion. I assume this is for power saving purposes? Otherwise one could just
say you should not use the lower part of the voltage range. And DVFS is for the
controller's core logic and not I/O?

ChenYu

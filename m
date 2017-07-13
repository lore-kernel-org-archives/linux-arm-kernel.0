From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 13 Jul 2017 10:39:34 +0530
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <CAGb2v67XtUcqdjMt-Ln6zn3ShH4JFmjkK4bPSpUNZpJqnmwivw@mail.gmail.com>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
 <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
 <CAGb2v67XtUcqdjMt-Ln6zn3ShH4JFmjkK4bPSpUNZpJqnmwivw@mail.gmail.com>
Message-ID: <20170713050934.GB352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-17, 10:52, Chen-Yu Tsai wrote:
> I'm afraid the regulator case still doesn't make sense. The voltage
> constraints should be set within each supplies device node. This was
> explained in the discussion in v1 [1].

I thought we were discussing about something I mentioned in one of my example
but never to a point that the regulator problem doesn't exist at all. Perhaps I
misunderstood your concerns. Anyway, lemme try once more with a better example.

Regulator shared by: LCD and MMC (both can do DVFS) and the min/max constraint
that can be set by the consumers of the regulator (both LCD/MMC) are: 1.5 V to
3 V.

The bootloader has programmed the LCD to work at the highest pixel frequency,
which needs the voltage to be in range from 2.5 - 3 V.

Now MMC can get probed first and it can try to bring the voltages below 2.5 V.
Though, 1.5 - 2.5 is a valid range for the LCD, but not at the current pixel
frequency.

Does that sound like a valid problem?

-- 
viresh

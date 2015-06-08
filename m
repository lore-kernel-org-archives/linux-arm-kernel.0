From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 08 Jun 2015 09:32:38 +0530
Subject: [RFC 1/7] thermal: qcom: tsens: Add a skeletal tsens drivers
In-Reply-To: <7hpp59zpfv.fsf@deeprootsystems.com>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>	<1429796773-7151-2-git-send-email-rnayak@codeaurora.org>
 <7hpp59zpfv.fsf@deeprootsystems.com>
Message-ID: <557513DE.2050505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

>
> I was trying this series on linux-next with Srini's eeprom v4 and my
> first attempt was to build the eeprom, qfprom and tsens drivers as
> built-in.  Unfortunately, the tsens driver probed before the
> eeprom/qfprom driver so failed here with the "calibration failed"
> message.
>
> Building things as modules worked better, but you might want to take a
> look at possibly using -EPROBE_DEFER here?

The driver does return -EPROBE_DEFER in case the calibration fails
when tsens is probed before qfprom. It does however also show the
error message "calibration failed" which is a little misleading and
needs fixing. What target were you trying this on? I will give it a
try again to make sure things work.

regards,
Rajendra

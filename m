From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 29 Apr 2015 15:19:23 +0530
Subject: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
In-Reply-To: <CAMuHMdW8OKDODHTw=A=vCFR9PN3KUr_fiGSiNkn0Q7Q16axU6g@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org>	<CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>	<553A21C7.4060506@codeaurora.org>	<CAMuHMdV_WD7vay-5VC20izUWFjc8rSW4wZQq6Y3xAa+SU0Quig@mail.gmail.com>	<7hh9s1xrut.fsf@deeprootsystems.com>	<553EF5D4.60900@codeaurora.org>
 <CAMuHMdW8OKDODHTw=A=vCFR9PN3KUr_fiGSiNkn0Q7Q16axU6g@mail.gmail.com>
Message-ID: <5540A923.8000104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..

>> I guess I can also control the rest of the devices the same way, just
>> that the genpd on/off for them would do nothing.
>> That way I don't have to use pm_clk_add_notifier() and can also
>> associate the power domain (with no on/off control) to devices
>> through DT (and there isn;t any duplication of code in the drivers)
>
> That looks similar to what we have on R-Mobile: some devices are in
> controllable power areas, other are in an "always on" power area. All (most)
> devices have controllable clocks, which we also control through the PM
> domain. "git grep sysc-rmobile" will point you to the related code and DTS.

Geert, thanks, I was wondering how you handle the !CONFIG_PM case for
rmobile. I mean who turns the clocks on for the devices when you build
with CONFIG_PM disabled?

>

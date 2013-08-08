From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Aug 2013 10:52:57 -0500
Subject: [PATCH 2/6] ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0
 driver
In-Reply-To: <CAKohpo=zYBVha_L7D+FWUEO=a6byeiuGtNBmh-CRhSmfkT=QrQ@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
 <52028719.8070908@wwwdotorg.org>
 <CAKohpo=MpOyMGFTGeZWmoCRwmZ7+nQtP_yCGokPanEVYL0xbMw@mail.gmail.com>
 <52029811.9080704@wwwdotorg.org>
 <1375970318.4276.52.camel@weser.hi.pengutronix.de>
 <CAKohpon=GGn5-8ucTrrf6TyPMn3+1Oh6Sd5bAj_ztpVDONZ3QA@mail.gmail.com>
 <1375971749.4276.61.camel@weser.hi.pengutronix.de>
 <CAKohpo=zYBVha_L7D+FWUEO=a6byeiuGtNBmh-CRhSmfkT=QrQ@mail.gmail.com>
Message-ID: <CAGo_u6oArfcA3Ek_zKaWgkJm9G8U1NNGvhHSBU8Dg3L00NpGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 8, 2013 at 9:37 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 August 2013 19:52, Lucas Stach <l.stach@pengutronix.de> wrote:
>> You can certainly define the mapping table in DT where a specialized
>> Tegra cpufreq driver could read it in and then map frequency to voltage.
>> But that's a runtime decision, as Speedo and process ID are fuse values
>> and can not be represented in DT.
>
>> The problem with this is that the hardware description now associates
>> voltages with certain frequencies and even if they are not used by the
>> Linux driver they are plain wrong.
>
> Hmm. I understand.
> Then we probably need mach-tegra/opp.c to call opp_add() for all such
> OPPs.. Neither DT nor cpufreq driver are the right place for this.

This is similar to what I suspected might be the case on other
platforms (in addition to known iMx and OMAP). Could you see/comment
on [1] to see if it meets your needs.

We should like to avoid dealing custom SoC specific OPP, if we are
able to generalize the need.  ofcourse, I am yet to submit a official
proposal, but more SoCs the current proposal can handle, the better it
will be for all of us.

[1] http://marc.info/?l=linux-pm&m=137589225305971&w=2
--
Regards,
Nishanth Menon

From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Mar 2015 12:45:55 +0000
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
 <20150311105307.GW28806@sirena.org.uk>
 <CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
Message-ID: <20150311124555.GB28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 04:33:49PM +0530, Viresh Kumar wrote:

> On mediatek platform, they need to configure two regulators in order to change
> DVFS state of the big cluster. The generic cpufreq-dt driver and earlier OPP
> bindings have support for a single regulator only and so what Pi-cheng tried
> to do is,
> - Configure one of the regulators using cpufreq-dt
> - And other one using cpufreq frequency change notifiers

> This looks awkward..

> What I suggested was to create another virtual regulator for CPU which will
> eventually configure both the regulators. And so the question that such
> virtual regulators are allowed or not.

Ugh, no - that's a hideous bodge which is only going to create trouble
later.  Remember, DT is an ABI and should describe the hardware so if
we're doing bodges that are visible there to shoehorn things onto our
implementation that's bad.  The concerns that Pi-Cheng had about what
happens if the PMIC gets changed definitely seem relevant here too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/37a50661/attachment.sig>

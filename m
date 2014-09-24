From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Sep 2014 18:47:46 -0300
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <54232D9C.5070404@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de> <20140825080123.GA12289@dragon>
 <53FB1041.5010208@lategoodbye.de>
 <CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>
 <CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>
 <540412A9.4090806@lategoodbye.de>
 <CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>
 <542093C0.1040004@lategoodbye.de>
 <CAOMZO5A0of3_arOx2z0_t7xN37jQjJ5uU4gwcsgCuSdpBJJVzw@mail.gmail.com>
 <54232D9C.5070404@lategoodbye.de>
Message-ID: <CAOMZO5BN8APenWCsy7uHbYNQ4q0-QxorAdGPKBHOHPcUzp2PYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 5:46 PM, Stefan Wahren <info@lategoodbye.de> wrote:

> thanks, registering cpufreq-cpu0 and adding missing properties reg & clocks
> did the trick.
>
> Now the sys interface of cpufreq is available and the mxs-regulator seems to
> handle frequency change. But the frequency selection do not work as
> expected. If i set cpu frequency to 454736, 392727 or 261818 kHz, the

Why 454736 instead of 454MHz? Same for the other values.

> cpufreq driver change it silently to 240000 kHz.

24MHz is the osc clock. It seems you did not turn on the PLL0.

Check the POWER bit of HW_CLKCTRL_PLL0CTRL0 register.

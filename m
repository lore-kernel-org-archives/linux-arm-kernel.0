From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 18:07:51 +0200
Subject: [PATCH] ARM: smp_twd: reprogram twd based on clk notifier
In-Reply-To: <CACRpkdamYMhduj42-reu6QjQiso65=Wy_bNF37gENDBrBbQ5=Q@mail.gmail.com>
References: <1347005967-7604-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdamYMhduj42-reu6QjQiso65=Wy_bNF37gENDBrBbQ5=Q@mail.gmail.com>
Message-ID: <CACRpkda6u7ZL9Rj=6+sMUTMs9zjV10kneUguugTuPziQvS68dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 6:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 7, 2012 at 10:19 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>> -static struct notifier_block twd_cpufreq_nb = {
>> -       .notifier_call = twd_cpufreq_transition,
>> +static struct notifier_block twd_clk_nb = {
>> +       .notifier_call = twd_rate_change,
>
> But what happens if there is a platform which is now using this through
> cpufreq and has not yet switched to the common clock? It regresses
> right, because no notifications arrive anymore? Does it even compile?

Bah too late in the afternoon :-(

So the real question is - are we sure that imx6 is the last platform
migrated to common clock of all those using the CPUfreq scaling
(this seems to be the last piece) such that
we don't break anything....

Yours,
Linus Walleij

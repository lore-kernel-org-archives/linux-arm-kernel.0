From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 20:56:34 +0200
Subject: [PATCH 189/228] cpufreq: dbx500: remove calls to
 cpufreq_notify_transition()
In-Reply-To: <6fbcd6c0c6799d62f379b7c02ef08a93714b75a9.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <6fbcd6c0c6799d62f379b7c02ef08a93714b75a9.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdY9wwEJ-kjPZyh1gtrmULy3tyKuU_3s-3CZmP0YWz87wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 3:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Most of the drivers do following in their ->target_index() routines:
>
>         struct cpufreq_freqs freqs;
>         freqs.old = old freq...
>         freqs.new = new freq...
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
>
>         /* Change rate here */
>
>         cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
>
> This is replicated over all cpufreq drivers today and there doesn't exists a
> good enough reason why this shouldn't be moved to cpufreq core instead.
>
> Earlier patches have added support in cpufreq core to do cpufreq notification on
> frequency change, this one removes it from this driver.
>
> Some related minor cleanups are also done along with it.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

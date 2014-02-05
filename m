From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 05 Feb 2014 14:49:53 +0100
Subject: [PATCH v2 7/7] cpufreq: exynos: remove all exynos specific cpufreq
 driver support
In-Reply-To: <CAGo_u6r7LApS3sPHeQD3ufunnAm2sA4dW7N+M2v6UYaX8XZY8w@mail.gmail.com>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <1390047057-2239-8-git-send-email-thomas.ab@samsung.com>
 <20140120090815.39e8c21a@amdc2363>
 <CAJuA9agAQRK8NjkYU7Pr-z2AxyUoD7+NH+Y+6Ar9eCi_tbatgQ@mail.gmail.com>
 <20140205124459.61c7da0e@amdc2363>
 <CAJuA9aiokvq-=a-hK=nJnTkZTGF1Zc2ERXk2rpk-Xv7gUHaVpw@mail.gmail.com>
 <CAGo_u6r7LApS3sPHeQD3ufunnAm2sA4dW7N+M2v6UYaX8XZY8w@mail.gmail.com>
Message-ID: <20140205144953.15acfd09@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

> On Wed, Feb 5, 2014 at 6:43 AM, Thomas Abraham <ta.omasab@gmail.com>
> wrote:
> > Okay, thanks. Initially it looked like adding boost frequencies into
> > operating-modes would convolute it but I guess I was wrong. So I
> > will add support for looking up "boost-frequencies" property in
> > dev_pm_opp_init_cpufreq_table function and mark the frequencies
> > listed in this binding as CPUFREQ_BOOST_FREQ.
> I wonder if it is high time that we pop the cpufreq stuff out of opp.c
> other frameworks such as devfreq might choose to do things
> differently.

In my opinion, conceptually cpufreq's voltage and freq handling code
fits perfectly to OPP framework.

Yes. We can think about excluding cpufreq related code to e.g.
opp-cpufreq.c (and probably opp-devfreq.c if needed in the future).

> Regards,
> Nishanth Menon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

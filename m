From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 5 Mar 2015 15:28:47 +0800
Subject: [PATCH v2 1/4] cpufreq-dt: add clock domain and intermediate
 frequency support
In-Reply-To: <CAKohpo=zPsezGs8rqVzx3ChQkavs5z7eFMMETe12pc2mjm-8OA@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-2-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpomw6iDRRMxgmOORzZVeW4h2-LzKOsUcdpUnANcxiAYm+A@mail.gmail.com>
 <CALx668XCh46yMLajThuVzba9RRSxf+tEkNuMP9J7w-=vsZN8-Q@mail.gmail.com>
 <CAKohpo=zPsezGs8rqVzx3ChQkavs5z7eFMMETe12pc2mjm-8OA@mail.gmail.com>
Message-ID: <CALx668VZ4QMjFWssbjpZfcUKWJAYET81r3=jKHyAosUKDsbbBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 March 2015 at 11:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 5 March 2015 at 09:02, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> In the case of Mediatek SoC, the intermediate frequency might not be one entry
>> of OPP table. To elaborate, the source clock node of the CPUs/Cluster on
>> Mediatek SoC is a mux. The mux has several PLLs as parents. When we are
>> doing CPU frequency scaling, the mux should re-parent to another stable PLL,
>> wait until the original parent PLL become stable, and then switch back to the
>> original parent. In this case, we could but we might not want the intermediate
>> frequency as part of OPP table. Therefore I save intermediate_freq instead of
>> intermediate frequency index in the cpufreq_dt_platform_datat struct.
>
> Hmm, I remember that discussion. Okay leave it as is.

Okay.

>
>> BTW, is this case that intermediate frequency is not necessarily be one entry
>> of OPP table supported in the OPPv2 bindings?
>
> Not yet, but will add a property for that.

Thanks for taking this case into consideration.

Best Regards,
Pi-Cheng

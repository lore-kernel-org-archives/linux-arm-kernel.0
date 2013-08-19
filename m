From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 19 Aug 2013 12:16:45 +0530
Subject: [PATCH V2 01/35] cpufreq: Implement light weight ->target_index()
 routine
In-Reply-To: <CAKohpo=HvR9_6DvhhPV0JcBnkmF5bc0pbCQrF7sk=FKOayhcRA@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <eb988fc9e72b90b7ba99f16405f5dcb072da7840.1376392602.git.viresh.kumar@linaro.org>
 <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
 <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
 <CADGdYn4LoFEfZTd2bT=iGKRb5M=7CfpG-suxf3L-V5HXH7QuPQ@mail.gmail.com>
 <CAKohpo=HvR9_6DvhhPV0JcBnkmF5bc0pbCQrF7sk=FKOayhcRA@mail.gmail.com>
Message-ID: <CADGdYn4q+13xkkF-TeFJ2-H27o9ArQETmgVNEoV_o9YzA0ebDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 11:49 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19 August 2013 11:46, amit daniel kachhap <amit.daniel@samsung.com> wrote:
>> I meant that something like 2 policies can be registered SCALE_DIRECT/STEPS.
>> if SCALE_DIRECT is registered than target will be called with exact
>> frequency. SCALE_STEPS will behave as currently happening. This way
>> target_index api may not be needed. But looks like Rafael and others
>> are fine with your approach so you can ignore this :)
>
>
>  Why wouldn't we need target_index in case of SCALE_DIRECT? All
> target_index is doing now is changing platform specific registers to configure
> an exact frequency reported by index..

Actually target index will still be re-calculated if the platform
target driver wants to retrieve the index from the valid frequency or
directly set the valid frequency in the clock controller. So I wanted
a simpler/quicker cpufreq_frequency_table_target which just returns
the matching index from the valid frequency.



>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 11 Apr 2013 14:52:39 -0700
Subject: [PATCH] cpufreq: dbx500: Round to closest available freq
In-Reply-To: <1512269.3ZuqNVLx3s@vostro.rjw.lan>
References: <1365599175-22361-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb75wPjXEYdkqE6BOCsuFA_ZBc6GAz1m-5vHWSrSGKyUA@mail.gmail.com>
 <1512269.3ZuqNVLx3s@vostro.rjw.lan>
Message-ID: <516730A7.60206@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2013 2:33 PM, Rafael J. Wysocki wrote:
> On Thursday, April 11, 2013 10:33:07 PM Linus Walleij wrote:
>> On Wed, Apr 10, 2013 at 3:06 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>
>>> From: Mats Fagerstrom <mats.fagerstrom@stericsson.com>
>>>
>>> When reading the cpu speed, round it to the closest available
>>> frequency from the table.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Mats Fagerstrom <mats.fagerstrom@stericsson.com>
>> (...)
>>> +       /* The value is rounded to closest frequency in the defined table. */
>>> +       while (freq_table[i + 1].frequency != CPUFREQ_TABLE_END) {
>>> +               if (freq < freq_table[i].frequency +
>>> +                  (freq_table[i + 1].frequency - freq_table[i].frequency) / 2)

if (freq < (freq_table[i].frequency + freq_table[i + 1].frequency) / 2)

is easier to read.



>>>                          return freq_table[i].frequency;
>> Oh that works, clever.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Thanks, applied.
>
> Rafael
>
>

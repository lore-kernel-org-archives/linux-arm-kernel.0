From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 24 Aug 2011 10:02:18 +0200
Subject: [PATCH] ARM: ux500: send cpufreq notification for all cpus
In-Reply-To: <CAH9JG2Wd3Lv6670N6Nsg-AWjYGh4uZsabeqinTOGcpQ4nCKnYw@mail.gmail.com>
References: <1314168245-2373-1-git-send-email-vincent.guittot@linaro.org>
	<CACRpkdaONJ+Vdx4JCPfWoqavQahiSgVGv5i=h3+J1kE2V=Q8SA@mail.gmail.com>
	<CAH9JG2Wd3Lv6670N6Nsg-AWjYGh4uZsabeqinTOGcpQ4nCKnYw@mail.gmail.com>
Message-ID: <CAKfTPtDDz9N9tsYaD6WwZh6AYLG+MwhbN_rRxKyQfZAfZk_bMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2011 09:56, Kyungmin Park <kmpark@infradead.org> wrote:
> On Wed, Aug 24, 2011 at 4:42 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Aug 24, 2011 at 8:44 AM, Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>>
>>> The same clock is used for all cpus so we must notify the frequency change
>>> for each one in order to update the configuration of all twd clockevents.
>
> BTW, does it same as other ARM cpus?. e.g., exynos4 has same codes as this.
>
> How to you think it? Need to modify the same way?
>

yes, each ARM platform which uses twd timer should check that the
notification is sent for each cpu.

> Thank you,
> Kyungmin Park
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Yours,
>> Linus Walleij
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>

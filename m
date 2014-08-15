From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 15 Aug 2014 13:26:34 -0600
Subject: [PATCH 07/10 v3] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <DEE44AFE682197449410588EB783A5146887DDF1CA@BUNGLE.Emea.Arm.com>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
 <1407435706-19441-8-git-send-email-mathieu.poirier@linaro.org>
 <DEE44AFE682197449410588EB783A5146887DDED0F@BUNGLE.Emea.Arm.com>
 <CANLsYkxmCg2fZaORYzCHiBx4ugtP+67TJfPmiB7WiqG_s760Mg@mail.gmail.com>
 <DEE44AFE682197449410588EB783A5146887DDF1CA@BUNGLE.Emea.Arm.com>
Message-ID: <CANLsYkyYaMOSA5bw2AZrymkYZ0rDErPjq6RB+7CTSMN7=ytzpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SNIP...

>
>
>> > Does that mean ETM can't be enabled over cpu power-down?
>> > In the case where an ETM is powered up and the cpu is not,
>> > you might want to program and enable the ETM, to trace the
>> > cpu's power-up sequence.
>>
>> This a valid usecase that I had not considered - ok, I'll look into
>> that.

The situation can be fixed by only calling "etm_enable_hw()" if the
CPU is on line.  Otherwise the cpu callback can deal with configuring
the ETM/PTM before the processors starts its initialisation routing,
allowing one to trace the boot process.

>>
>> >
>> > Or, if the ETM is powered down but can be powered up independently
>> > of the CPU, etm_enable could do so.
>>
>> Once again, I'm not sure that I fully grasp your train of thoughts -
>> please rephrase or be more specific.
>
> I meant that if the ETM was in a separate power domain from the CPU
> and could be powered up before the CPU was, the driver could take some
> action to power up the ETM's power domain.

Agreed - I currently don't have a test platform for this but is it
something that regularly comes up.  Implementing something of that
nature will be bumped up to the top of the priority list when I get my
hands on a platform that works that way.  Until then I'd rather not
introduce code that I can't test.

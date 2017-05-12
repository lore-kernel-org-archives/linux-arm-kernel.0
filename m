From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 12 May 2017 12:36:32 +0200
Subject: [RFC kvm-unit-tests PATCH 5/8] Makefile: add explicit mkdir for
 .o targets
In-Reply-To: <87mvaj4din.fsf@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-6-alex.bennee@linaro.org>
 <a8eb190a-3487-1a89-0069-789b62860b3e@redhat.com> <87mvaj4din.fsf@linaro.org>
Message-ID: <bac2056a-c771-6188-0066-7e3236719ff0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/2017 17:30, Alex Benn?e wrote:
>>>
>>>  %.o: %.S
>>> +	mkdir -p $(dir $@)
>> Should this use @ for cleanliness?
> > I'm not sure I follow. Did you mean use $(@D) directly?

That too, but I was thinking of using "@mkdir" to avoid spamming the
output with mkdir commands.

Paolo

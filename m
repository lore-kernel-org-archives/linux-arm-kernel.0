From: jcm@redhat.com (Jon Masters)
Date: Fri, 12 Sep 2014 17:10:32 -0400
Subject: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
In-Reply-To: <20140912200355.GD9234@xora-haswell.xora.org.uk>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <54134CE8.8070506@redhat.com>
 <20140912200355.GD9234@xora-haswell.xora.org.uk>
Message-ID: <54136148.40106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 04:03 PM, Graeme Gregory wrote:
> On Fri, Sep 12, 2014 at 03:43:36PM -0400, Jon Masters wrote:
>> On 09/12/2014 10:00 AM, Hanjun Guo wrote:
>>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>>
>>> ACPI 5.1 does not currently support S states for ARM64 hardware but
>>> ACPI code will call acpi_target_system_state() for device power
>>> managment, so introduce sleep-arm.c to allow other drivers to function
>>> until S states are defined.
>>
>> Aside: ACPI5.1 does define the Platform Communication Channel and CPC
>> (Collaborative Processor Performance Control). Some details need to be
>> fleshed out there for practical 64-bit ARMv8 server systems, but the
>> underpinnings and mechanisms are in place in the 5.1 specification that
>> can be built upon over time to achieve practical S-State equivalence.
                                                    ^ meant C/P sorry

> Disagree, S-States are about going to sleep or hibernating, that is
> nothing to do with CPU Performance.

Correct. In replying to the above, I was thinking about power and
performance management of components  - CPU (C/P), and device (D)
specific power/performance states - not the overall system (S) state,
and I went off on a tangent. That was off-topic. For the actual topic at
hand, that of global sleep, you are correct that only G0 (S0) and S5 are
really defined today. Though I do think that the PCC might be used to
actually implement overall system sleep state transitions later.

Jon.

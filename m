From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 22 Jun 2011 15:39:39 +0300
Subject: [RFC PATCH v2] Add ARM cpu topology definition
In-Reply-To: <BANLkTikpasc40ubaHZvJoTVehLWtxvYQqQ@mail.gmail.com>
References: <1308568795-1985-1-git-send-email-vincent.guittot@linaro.org>
	<20110622101423.GB2402@matterhorn1>
	<BANLkTikpasc40ubaHZvJoTVehLWtxvYQqQ@mail.gmail.com>
Message-ID: <BANLkTikQt8dgikHUM5NfYLjWwHgwLbeQrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 3:20 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> On 22 June 2011 12:14, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>> +
>>> +#define topology_physical_package_id(cpu) ? ?(cpu_topology[cpu].socket_id)
>>> +#define topology_core_id(cpu) ? ? ? ? ? ? ? ?(cpu_topology[cpu].core_id)
>>> +#define topology_core_cpumask(cpu) ? (&(cpu_topology[cpu].core_sibling))
>>> +#define topology_thread_cpumask(cpu) (&(cpu_topology[cpu].thread_sibling))
>>
>> These #defines are not used anywhere.
>
> They are used in topology.c driver and sched.c
>
>>
>>> +#define mc_capable() (cpu_topology[0].socket_id != -1)
>>> +#define smt_capable() ? ? ? ?(cpu_topology[0].thread_id != -1)
>>
>> Neither are these.
>
> They are used in sched.c
>

Ahh, sorry for the noise. Documentation/cputopology.txt is most illuminating.

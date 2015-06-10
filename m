From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 10 Jun 2015 10:03:15 +0200
Subject: [PATCH v2 0/3] Add code to release secondary cores from holding
 pen.
In-Reply-To: <7hd214sx9b.fsf@deeprootsystems.com>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
 <7hd214sx9b.fsf@deeprootsystems.com>
Message-ID: <5577EF43.6020600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 06/09/2015 05:43 PM, Kevin Hilman wrote:
> Peter Griffin <peter.griffin@linaro.org> writes:
>
>> Hi Maxime, Patrice, Srini, Kevin, Olof & Arnd,
>>
>> This patchset adds in the necessary code to manage the holding pen for STi
>> platforms.
>>
>> Due to all the STi upstream devs using JTAG to boot the STi boards, there
>> is currently a SMP bug when booting upstream kernels via u-boot where
>> only the primary core is brought up.
>>
>> This hasn't been noticed until now because when booting via JTAG the
>> stlinux_arm_boot script sets the PC of the secondary cores directly.
>>
>> With these patches applied booting via u-boot now works correctly.
>>
>> [    0.045456] CPU: Testing write buffer coherency: ok
>> [    0.045597] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.045734] Setting up static identity map for 0x40209000 - 0x40209098
>> [    0.065047] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.065081] Brought up 2 CPUs
>> [    0.065089] SMP: Total of 2 processors activated (5983.43 BogoMIPS).
>> [    0.065092] CPU: All CPU(s) started in SVC mode.
>>
>> Kevin / Olof / Arnd - Can you put this fix into the next ARM SoC fixes pull
>> request (if there is one)?
> At this stage of the cycle (we're already at -rc7) we limit things to
> strictly regression fixes, and seems this has been broken for some time,
> so I think this will have to wait for v4.2.
>
> After addresing the comments, Maxime should queue this up for arm-soc so
> we can get it in early in the v4.2-rc cycle.

Ok, I will take it for v4.2-rc cycle.

Thanks,
Maxime

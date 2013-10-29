From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Tue, 29 Oct 2013 10:42:37 +0530
Subject: [PATCH v3 4/4] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <20131025154051.GG10673@mudshark.cambridge.arm.com>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-5-git-send-email-vijay.kilari@gmail.com>
 <20131025154051.GG10673@mudshark.cambridge.arm.com>
Message-ID: <CALicx6vk98nydiNGakTTQSa5UREKODP6M4xeCQ7W5nMxV0V+Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

  Can you please consider this patch?.

On Fri, Oct 25, 2013 at 9:10 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Oct 18, 2013 at 12:07:49PM +0100, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> The function kgdb_breakpoint() sets up break point at
>> compile time by calling arch_kgdb_breakpoint();
>> Though this call is surrounded by wmb() barrier,
>> the compile can still re-order the break point,
>> because this scheduling barrier is not a code motion
>> barrier in gcc.
>>
>> Making kgdb_breakpoint() as noinline solves this problem
>> of code reording around break point instruction and also
>> avoids problem of being called as inline function from
>> other places
>>
>> More details about discussion on this can be found here
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/269732
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> I guess this goes via Jason's tree?
>
> Will

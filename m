From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 17 May 2013 17:48:23 +0800
Subject: [Bug] ARM 'perf' regression by commit a43cb95d5
In-Reply-To: <20130517093616.GC23112@mudshark.cambridge.arm.com>
References: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
 <20130517085530.GB22992@mudshark.cambridge.arm.com>
 <CACVXFVPEBXat3bPPuHzV535=xLoRMFd03Kjzp=NUF5E3KCq2=g@mail.gmail.com>
 <20130517093616.GC23112@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVP56EJb0BZ+w6hVAukQ-mN0e0Jn_GLw3XqXQqMwVGfNdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 5:36 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> It's probably easier if you choose a workload, otherwise it's difficult to
> see what is `correct' and what is broken. For example, your broken output
> seems to be in the smsc95xx driver, so assumedly there's a bunch of
> networking going on whereas your other output is in cpuidle_enter_state.

If all modules are removed, the result will become OK. And if I only insert one
module, the top sample will fall inside the only module, but I am sure
nothing is working on the symbols of the module.

>
> We need an apples-for-apples comparison if you think there's a bug in the
> kernel. Can you try profiling hackbench or something?
>
>> Or could anyone else try to verify the problem on their own environment?
>
> How are you running perf top?

sudo perf top

Thanks
--
Ming Lei

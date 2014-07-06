From: paul.burton@imgtec.com (Paul Burton)
Date: Sun, 6 Jul 2014 11:01:08 +0100
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
 <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
Message-ID: <20140706100108.GE804@pburton-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 10:03:39AM +0100, Lorenzo Pieralisi wrote:
> [CC'ing Preeti and Paul to check their opinions]
> 
> Hi Rafael,

snip

> > One question here.
> > 
> > Do you want this to be generally useful or is it just ARM-specific?
> 
> The first series was targeting ARM64, then I noticed that it might be
> used for ARM too (Daniel is working on that). Actually, I discovered
> that Power and MIPS can reuse at least the code that initializes the
> states data too, but I have to point out three things:
> 
> 1) state enter function method: in my bindings it is common for all
>    idle states, need to check if it applies to Power and MIPS too.
> 2) CPUIDLE_FLAG_TIMER_STOP and how to set it. It is non-trivial to
>    add code that detects what idle states lose the tick device context.
>    At the moment I am adding the flag by default to all idle states
>    apart from standbywfi on ARM, but that can be optimised. Unless we
>    resort to power domains (but that's not trivial), we can add a flag
>    to the idle states in DT (ie local-timer-stop or suchlike) to support
>    that. I think that it will be frowned upon but it is worth trying, would
>    like to know what other people think about this.
> 3) idle states bindings should be reviewed, I expect them to be valid
>    on other architectures too, but I need acknowledgments.
> 
> I think this series is not far from being ready to be upstreamed, I
> would be certainly happy if it can be reused for other archs too so
> just let me know.
> 
> Thanks !
> Lorenzo

Sorry for the delayed reply, I'm still catching up with mail after some
time off.

On the MIPS CPS systems I'm working with we are able to detect which
states are supported by reading config registers, so there's no need
for these systems to have available states described in DT.

Thanks,
    Paul

From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 16:59:36 +0100
Subject: [Bug] ARM 'perf' regression by commit a43cb95d5
In-Reply-To: <CACVXFVPJyKrOBk+JjsfCi+aQ8snQ7PsEJVuOnuTkrWBYEnvDtA@mail.gmail.com>
References: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
 <20130517085530.GB22992@mudshark.cambridge.arm.com>
 <CACVXFVPEBXat3bPPuHzV535=xLoRMFd03Kjzp=NUF5E3KCq2=g@mail.gmail.com>
 <20130517093616.GC23112@mudshark.cambridge.arm.com>
 <CACVXFVP56EJb0BZ+w6hVAukQ-mN0e0Jn_GLw3XqXQqMwVGfNdA@mail.gmail.com>
 <20130517095423.GD23112@mudshark.cambridge.arm.com>
 <CACVXFVPJyKrOBk+JjsfCi+aQ8snQ7PsEJVuOnuTkrWBYEnvDtA@mail.gmail.com>
Message-ID: <20130517155936.GQ23112@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 11:07:37AM +0100, Ming Lei wrote:
> On Fri, May 17, 2013 at 5:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, May 17, 2013 at 10:48:23AM +0100, Ming Lei wrote:
> >> On Fri, May 17, 2013 at 5:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> >
> >> > It's probably easier if you choose a workload, otherwise it's difficult to
> >> > see what is `correct' and what is broken. For example, your broken output
> >> > seems to be in the smsc95xx driver, so assumedly there's a bunch of
> >> > networking going on whereas your other output is in cpuidle_enter_state.
> >>
> >> If all modules are removed, the result will become OK. And if I only insert one
> >> module, the top sample will fall inside the only module, but I am sure
> >> nothing is working on the symbols of the module.

Ok, I tried to reproduce this on my TC2 with 3.10-rc1 and perf top looks
fine. I also tried loading your spi-altera module and it made no difference.

I'm using a fairly old perf tool (reports its version as 3.5.5).

Will

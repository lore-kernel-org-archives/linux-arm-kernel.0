From: jsun@junsun.net (Jun Sun)
Date: Mon, 1 Aug 2016 12:08:26 -0700
Subject: Can cores have different CPU features in a SMP system?
In-Reply-To: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
References: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
Message-ID: <CAP5Nno4CN18x_L-UQPm0Wp7hFSQAKtRobV94iBkcB9y4-UeRpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I looked at the kernel source code again.  Kernel currently only
detects CPU features of CPU0 and use it for all other CPUs.   In other
words, it is assuming all cores must have the same CPU features, which
in a sense is a form of "enforcing".

As a result, it is definitely no-no to have cores with different CPU
features, which is what I suspected.  Case closed. :)

Jun

On Fri, Jul 29, 2016 at 2:30 PM, Jun Sun <jsun@junsun.net> wrote:
> One specific example is that if a phone has two clusters.  Cores in
> one cluster has v8 crypto extension and cores in the other don't.
> Will this work?
>
> My gut feeling is no, since many apps query cpu features at run-time.
> And process can migrate among cores.  If an app starts on a core with
> CE and migrates to another core without CE.  Illegal instruction fault
> will happen.
>
> Just wanna confirm if this is indeed the case.  Surprisingly google
> search did not yield any meaningful answers.
>
> Cheers.
>
> Jun

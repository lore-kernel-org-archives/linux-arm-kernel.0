From: raghupv30@gmail.com (Raghu Pv)
Date: Thu, 22 May 2014 10:40:39 +0100
Subject: CLONE from pthread_create fails with ERESTARTNOINTR and
 application crashes
In-Reply-To: <20140522090447.GA14641@arm.com>
References: <CAGJAg9EHSgOg3trryA5Zb5ms8pfTX6Y7DF4s-mEP6YZmD8twVw@mail.gmail.com>
 <20140522090447.GA14641@arm.com>
Message-ID: <CAGJAg9Ew=7=R3oa5OfasCwbkWmwOBYB-6frr4oqC6su9CP7jbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi WiIl,

Many Thanks for responding to my issue.

I am currently using 2.6.18.8 kernel for  armv4tl platform.

We are seeing this issue on our larger system codebase which happens
when pthread_create/clone call is interrupted by a signal.

I am currently working out to come up a sample code segment that can
reproduce the issue.

If you are aware of this issue in 2.6.18.8 kernel and if it is fixed
in subsequent commits please help me to find the relevant patches that
can resolve the problem.

I look forward for your response.

Thanks in advance.

Thanks,
Raghu

On 22 May 2014 10:04, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, May 21, 2014 at 02:40:16PM +0100, Raghu Pv wrote:
>> CLONE from pthread_create fails with ERESTARTNOINTR and application crashes
>
> [...]
>
>> Executing a multithreaded application that creates and terminates
>> threads and also there a lot of signals
>
> Do you have sample source for that?
>
>> If a signal arrives during execution of clone(), clone is returning
>> ERESTARTNOINTR to userspace.
>
> With which kernel version? Your quote from fork.c doesn't match mainline.
> Can you reproduce with -rc6?
>
> Will

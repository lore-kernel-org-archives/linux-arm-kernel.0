From: joel@jms.id.au (Joel Stanley)
Date: Wed, 12 Sep 2018 08:23:29 +0930
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
Message-ID: <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2018 at 07:48, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> On 9/11/2018 1:41 PM, Guenter Roeck wrote:
> > On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:

> >> I checked this patch again but it doesn't have any change that could
> >> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
> >> and will share if I find something.
> >>
> > The problem may be that qemu and the new code disagree how interrupts
> > should be generated and handled, and the new code does not handle the
> > interrupts it receives from the simulated hardware. This will result
> > in i2c device probe failure, which in turn can cause all kinds of
> > problems.
> >
>
> Yes, that makes sense. Looks like it should be reverted until the issue
> is fixed. Will submit a patch to revert it.

Let's not rush. The qemu model was written in order to allow us to
test the kernel code, and was validated by the kernel driver we have.
We've had situations in the past (with the i2c driver in fact) where a
change in the driver required an update of the model to be more
accurate.

I suggest we wait until Cedric has a chance to look at the issue
before reverting the patch.

Cheers,

Joel

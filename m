From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 6 Mar 2013 15:43:32 +0200
Subject: v3.9-rc1: swapper/0 [ INFO: possible circular locking dependency
 detected ]
In-Reply-To: <51371B5E.1000508@free-electrons.com>
References: <51371B5E.1000508@free-electrons.com>
Message-ID: <CAB7JpEHJdKeOhkME-6mMdPY6VyTQwFvM33+gxg4X9ZpQv1=6RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2013 12:33, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> Just noticed this in 3.9-rc1 on an iMX28 (ARM) board with a config
> based on mxs_defconfig. I'm using the patchset "Add tested id switch
> and vbus connect detect support for Chipidea" from Peter Chen in its
> 10th version [1], rebased on top of 3.9-rc1, but since this doesn't
> modify the locks present in the udc_irq function, I think the problem
> is elsewhere.

>From a quick look at the current chipidea code, I don't see any place
where we might try to take cdev->lock under ci->lock. I should have a
better look at Peter's patchset to see if it can trigger that. Peter,
have you seen anything like that with your code?
Is this easy to trigger (I would assume it is)? Can you post the
contents of "events" debug file in sysfs?

Thanks,
--
Alex

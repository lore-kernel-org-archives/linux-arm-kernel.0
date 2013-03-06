From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 06 Mar 2013 15:11:05 +0100
Subject: v3.9-rc1: swapper/0 [ INFO: possible circular locking dependency
 detected ]
In-Reply-To: <CAB7JpEHJdKeOhkME-6mMdPY6VyTQwFvM33+gxg4X9ZpQv1=6RQ@mail.gmail.com>
References: <51371B5E.1000508@free-electrons.com>
 <CAB7JpEHJdKeOhkME-6mMdPY6VyTQwFvM33+gxg4X9ZpQv1=6RQ@mail.gmail.com>
Message-ID: <51374E79.9050408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Thanks for your reply.

Le 06/03/2013 14:43, Alexander Shishkin a ?crit :
> On 6 March 2013 12:33, Maxime Ripard 
> <maxime.ripard@free-electrons.com> wrote:
>> Just noticed this in 3.9-rc1 on an iMX28 (ARM) board with a config
>>  based on mxs_defconfig. I'm using the patchset "Add tested id 
>> switch and vbus connect detect support for Chipidea" from Peter 
>> Chen in its 10th version [1], rebased on top of 3.9-rc1, but since 
>> this doesn't modify the locks present in the udc_irq function, I 
>> think the problem is elsewhere.
> 
> From a quick look at the current chipidea code, I don't see any place
> where we might try to take cdev->lock under ci->lock. I should have a
> better look at Peter's patchset to see if it can trigger that.

And from a quick git blame on top of Peter patches, it seems like
udc_irq has been left untouched by his patches.

> Peter, have you seen anything like that with your code? Is this easy
>  to trigger (I would assume it is)?

Quite easy yes, just plug a usb cable in gadget mode.

> Can you post the contents of "events" debug file in sysfs?

http://code.bulix.org/64liql-83101


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

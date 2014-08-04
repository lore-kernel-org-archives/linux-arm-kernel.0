From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 4 Aug 2014 15:49:57 +0100
Subject: [PATCH v3] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <CAKv+Gu-LQ9ahV5js0V5XgyRwUkrc3BOT9YoZj=mvwCEMQVXfow@mail.gmail.com>
References: <1405062556-14540-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140804130011.GI15082@console-pimps.org>
 <CAKv+Gu-LQ9ahV5js0V5XgyRwUkrc3BOT9YoZj=mvwCEMQVXfow@mail.gmail.com>
Message-ID: <20140804144957.GK15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 Aug, at 03:13:28PM, Ard Biesheuvel wrote:
> 
> Well, again, the spec allows it. But I am happy to remove it as it
> does not affect ARM anyway

Right, I understand why you added these now.

My personal opinion is that we shouldn't do the NMI dancing unless
absolutely necessary, e.g. because of corresponding kernel code paths.
The fact that the spec allows it doesn't necessarily mean we should
support it.

But I do like the idea of documenting that the spec allows for things
that we don't support, because that at least informs developers, when
they come snooping around this file, that they've got some additional
work to do if they want to call these functions from NMI context.

So the table you included is cool, and I think some additional sentences
along the lines of "... but we don't support calling all these functions
from NMI context" would be a good addition.

What do you think?

-- 
Matt Fleming, Intel Open Source Technology Center

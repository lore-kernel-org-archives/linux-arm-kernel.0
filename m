From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 01 May 2013 11:37:36 +0930
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <C52CCDD4-D8FB-4AD6-B83D-3B5251A7A0F5@suse.de>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
 <87obcyc9sh.fsf@rustcorp.com.au>
 <336C59AA-D5D7-472E-A8DA-EEB413DD6C68@suse.de>
 <CAAHg+Hj0tySbzUGnoFE9ybVYP291B-i8-Ck1EkwD57t8yG5wwg@mail.gmail.com>
 <C52CCDD4-D8FB-4AD6-B83D-3B5251A7A0F5@suse.de>
Message-ID: <87sj27xxjr.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Graf <agraf@suse.de> writes:
> There are not device specific registers in
> virtio-console. Virtio-console lives behind a virtio bus which doesn't
> know what these registers are.

You're not going to make coherent arguments without reading that actual
patch we're discussing.  And you're going to just waste everyone else's
time.

> Even if you shove it into config space,

Which is what the patch does...

> it'd be broken because config access happens without intercepts on
> some platforms.

But people keep assuming it, which is one reason virtio_ccw switched
from passive lguest-style config to active.  Only lguest and the old kvm
virtio use it, and lguest can change.

An emergency output is a reasonable idea, and this is a reasonable
implementation.  The question is practical: will it be used?  Because we
don't implement reasonable ideas which aren't going to be used.

Cheers,
Rusty.

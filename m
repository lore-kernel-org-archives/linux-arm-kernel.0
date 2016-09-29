From: agraf@suse.de (Alexander Graf)
Date: Thu, 29 Sep 2016 17:11:36 +0200
Subject: [PATCH 0/3] Support userspace irqchip with arch timers
In-Reply-To: <20160927190806.22988-1-christoffer.dall@linaro.org>
References: <20160927190806.22988-1-christoffer.dall@linaro.org>
Message-ID: <57ED2F28.1090100@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2016 09:08 PM, Christoffer Dall wrote:
> Hi Alex,
>
> Marc and I have been looking at this during Linaro connect and have
> slightly reworked your patch into this small series.
>
> It would be good if you could have a look at it and test it out.

Tested-by: Alexander Graf <agraf@suse.de>

Works fine so far :).

> I've tested it with your QEMU, and it works for UP, but secondary CPUs
> fail to come up, and it looks like the kernel never gets an IPI for
> those CPUs from userspace.  Any chance you're willing to take a look at
> that?

I can try, but not very soon. I doubt it's something fundamental - we 
probably just don't synchronize kvm/qemu state properly on IPIs (read: a 
QEMU bug).

> Also, let me know if the split of your patch with preserving your
> authorship is ok with you.

Works for me :)


Alex

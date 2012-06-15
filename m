From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 15 Jun 2012 18:55:32 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <87r4tgvii8.fsf@lebrac.rtp-net.org>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
 <20120615104140.24bf25f3@skate>
 <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
 <87r4tgvii8.fsf@lebrac.rtp-net.org>
Message-ID: <CAMW5UfZt_5ebcbRPfKn+aYkjzHcx5k7yV_PDmhdJaCMZos4Xsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> What I did this morning:
>>
>> make
>> make kirkwood-goflexnet.dtb
>> cat arch/arm/boot/kirkwood-goflexnet.dtb >> arch/arm/boot/zImage
>> make uImage
>>
>> That resulted in: http://pastie.org/4092019
>>
> [ ? 18.294288] [<c055f99c>] (kirkwood_init+0x50/0x7c) from [<c056023c>] (goflexnet_init+0x8/0x7c)
>
> seems wrong. You don't have to call kirkwood_init() in DT case afaik.
>
> Arnaud

You're correct Arnaud, chalk that up to another rookie mistake on my
part.  So close now.  Correcting goflexnet_init, I now only get one
bit of noise during init, seems to be related to cfq?  The kernel sees
my drives and volumes, but it's still not proceeding to mount a rootfs
and proceed with the boot.

http://pastie.org/4095067

My next line of thought is to tweak my kernel conf so I'm just using
noop, and to specify my rootfs as a compiled in kernel arg to see if
there is something going on with how uboot args are getting passed on.
 I'd expect it to complain about a missing rootfs if it wasn't getting
that string but I'm not sure how else to verify correct behavior.

Josh C

From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 15 Jun 2012 14:58:55 +0200
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
 (Josh Coombs's message of "Fri, 15 Jun 2012 08:40:48 -0400")
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
 <20120615104140.24bf25f3@skate>
 <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
Message-ID: <87r4tgvii8.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh Coombs <josh.coombs@gmail.com> writes:

> Thomas, Andrew,
>
> You were both correct.  After one additional test failure last night
> and a lot more reading I reached the same conclusion, I was foolishly
> thinking .dtbs would be automatically appended to the kernel when
> configured to support that method of including them.
>
> What I did this morning:
>
> make
> make kirkwood-goflexnet.dtb
> cat arch/arm/boot/kirkwood-goflexnet.dtb >> arch/arm/boot/zImage
> make uImage
>
> That resulted in: http://pastie.org/4092019
>
[   18.294288] [<c055f99c>] (kirkwood_init+0x50/0x7c) from [<c056023c>] (goflexnet_init+0x8/0x7c)

seems wrong. You don't have to call kirkwood_init() in DT case afaik.

Arnaud

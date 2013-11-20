From: bgamari.foss@gmail.com (Ben Gamari)
Date: Tue, 19 Nov 2013 22:06:50 -0500
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
In-Reply-To: <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
References: <87hab9agjr.fsf@gmail.com>
 <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
Message-ID: <87wqk3n54l.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chao Xu <caesarxuchao@gmail.com> writes:

> Hi,
>
> I also try to boot v3.12 on my pandaboard rev A2, but it hangs at
> "starting kernel". My SD card is originally loaded with a linaro 12.04
> ubuntu-developer image. I have tried with v3.7 and v3.8 uImage and
> both of them work normally, but v3.12 hangs. Is there any trick I
> missed? Do I need to use the new u-boot as used by Ben?
>
I've written up some of my experiences bringing up 3.12 on the
PandaBoard here[1]. You may find it helpful. Regardless, I would
definitely try upgrading u-boot.

> And here is a separate problem with building u-boot. I cloned the
> upstream u-boot repository. The latest commit is
> c2e5e802ecb7ab668ce9911b210ed68c804b349f. Then I did:
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- omap4_panda_config
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
> cp MLO u-boot.img /media/boot/
> But when turn on my pandaboard, there is NO output from the serial
> console. I didn't change the other file in the boot partition. They
> are from linaro 12.04 ubuntu-developer image.
>
I would check that you have earlyprintk enabled (both in the kernel
configuration as well as on the kernel command line). Moreover, ensure
that the correct serial devices is selected for low-level debug output
(in the kernel configuration).

Cheers,

- Ben

[1] http://bgamari.github.io/posts/2013-11-17-running-modern-kernel-on-pandaboard.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/380fc28b/attachment-0001.sig>

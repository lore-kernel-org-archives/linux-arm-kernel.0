From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 2 May 2010 03:01:48 +0200
Subject: Versatile QEMU broken in -next
Message-ID: <r2r63386a3d1005011801v5ad139b9y5852700f0575544d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some hours trying to boot the -next tree on
Versatile PB in QEMU, I git-bisected until I found
that one of these commits breaks Versatile for QEMU
(it just hangs, following quoting git bisect):

There are only 'skip'ped commits left to test.
The first bad commit could be any of:
7813a88b9edca512fe753be1f9a575a3e28b5929
e9a0579b23600c0445675866935c753f7ed11f2d
4207503eec1a8556b3400059058ec408424da222
a0b6419dd2585a88d08d786d44e2ee30b96d8720
e150fb3f218dced597a138c1ee2d773d8ef7dea3
f6b1158d63d6fd8af7cf33b6ba46ba39c462a192
1f4eb371383774415f372396741c3ae48fc66de2
82a3290b6002fc89a965748f90fcba545e3c1c21
7b7e81a1a2b13a2c6ff03174491b20c6c9779eee
e44149eac96c3862c0d8a8e94a3b558e24b37df4
608d8fcf7eb7fc467ecc41b26bfc6294fc9afcb0
8863e0e4f10a71e0ea053e6aae77af3aec8c68ad
2e655a0c01c3a1b8d668f89bd89fb69e373d8952
8952b5244b52e7a44311ddaf9d614a96702931ed
f2b431ef83dc81bb633359b11d97639f04ebb212
We cannot bisect more!

The above cannot be drilled down since these
commits don't compile.

Notice: I have no Versatile board, so I cannot know
if it breaks on the actual hardware. I only know it
breaks in QEMU. I don't know why though.

I guess these all work nicely on a real board, so
I suspect it's a case of "QEMU needs to emulate
better", no real bug on real hardware.

Yours,
Linus Walleij

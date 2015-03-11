From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 15:57:19 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <550038C9.7010807@free-electrons.com>
References: <54FF21BE.2040506@list.ru> <550038C9.7010807@free-electrons.com>
Message-ID: <55003BAF.7070808@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 15:44, Gregory CLEMENT ?????:
> Hi Stas,
>
> On 10/03/2015 17:54, Stas Sergeev wrote:
>> Hello, the patch below is needed for a successful boot on armada-xp.
>>
> I am really surprised by this patch because I used the Armada XP based
> board in a daily base and I never saw this issue.
>
> Could you provide your .config?
>
> Also could you confirm that you use the dts from arch/arm/boot/dts
> wihtout any change?
With defconfig, and dts without a slightest change this
is still reproduceable (the logs I was posting to this thread
were done with _slightly_ modified config, and unmodified DT).

But... the board itself is modified. It is not a pure armada-xp-gp.
I still doubt that this crash is because of the board's mods, for
example please find the same crash here:
http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003872.html

---

Console logs for failures
=========================

arm-mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y
----------------------------------------------

	armada-xp-openblocks-ax3-4: FAIL: last 40 lines of boot log:
	------------------------------------------------------------

3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 55048012 02109471
[<c0186b78>] (_set_bit) from [<c01c9ba8>] (n_tty_set_termios+0x234/0x348)
[<c01c9ba8>] (n_tty_set_termios) from [<c01c9da8>] (n_tty_open+0xec/0x114)
---

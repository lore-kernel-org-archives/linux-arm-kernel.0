From: stsp@list.ru (Stas Sergeev)
Date: Wed, 11 Mar 2015 18:22:42 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55005B81.9020103@free-electrons.com>
References: <54FF21BE.2040506@list.ru> <550038C9.7010807@free-electrons.com>
 <20150311131433.GC8656@n2100.arm.linux.org.uk> <550058BE.3060406@list.ru>
 <55005B81.9020103@free-electrons.com>
Message-ID: <55005DC2.1060300@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

11.03.2015 18:13, Gregory CLEMENT ?????:
> On 11/03/2015 16:01, Stas Sergeev wrote:
>> 11.03.2015 16:14, Russell King - ARM Linux ?????:
>>> On Wed, Mar 11, 2015 at 01:44:57PM +0100, Gregory CLEMENT wrote:
>>>> Hi Stas,
>>>>
>>>> On 10/03/2015 17:54, Stas Sergeev wrote:
>>>>> Hello, the patch below is needed for a successful boot on armada-xp.
>>>>>
>>>> I am really surprised by this patch because I used the Armada XP based
>>>> board in a daily base and I never saw this issue.
>>> Can you provide some details about your board - does it have 8GB of
>>> memory, ranging from 0-0xf0000000, and 4G-8G ?
>> I wonder about this 256Mb memory hole.
> This is where the SoC registers are.
OK but it seems I am loosing this region of _physical_ memory:
---

[    0.000000]  memory size = 0x1f0000000
[    0.000000]  memory.cnt  = 0x2
[    0.000000]  memory[0x0]     [0x00000000000000-0x000000efffffff],
0xf0000000 bytes
[    0.000000]  memory[0x1]     [0x00000100000000-0x000001ffffffff],
0x100000000 bytes

---

As you can see, memory size is 0x1f0000000 instead of 0x20000000.
Why 256Mb are lost?

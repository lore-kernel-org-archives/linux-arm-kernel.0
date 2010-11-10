From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 11 Nov 2010 03:15:47 +0800
Subject: [PATCH 8/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C059864312A@SC-VEXCH1.marvell.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTikk334vRT3HE9bQWc3u_jyLJckAY9AW=pVUQNbq@mail.gmail.com>
	<AANLkTimn2b6b8r8au48LWk4G4tNfbbR=TypAC1f3=e3e@mail.gmail.com>
	<alpine.LFD.2.00.1011092149190.13911@xanadu.home>
	<25B60CDC2F704E4E9D88FFD52780CB4C059864312A@SC-VEXCH1.marvell.com>
Message-ID: <AANLkTinYJkngB3fEZoOvB6L+cDSJ0HekbR3eAryPQb6m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/10 Haojian Zhuang <hzhuang1@marvell.com>:
>
>
>>-----Original Message-----
>>From: Nicolas Pitre [mailto:nico at fluxnic.net]
>>Sent: 2010?11?10? 10:51 AM
>>To: Haojian Zhuang
>>Cc: Eric Miao; Haojian Zhuang; linux-arm-kernel; Zhou Zhu
>>Subject: Re: [PATCH 8/9] ARM: pxa: add iwmmx support for PJ4
>>
>>On Tue, 9 Nov 2010, Haojian Zhuang wrote:
>>
>>> On Tue, Nov 9, 2010 at 5:21 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> > On Mon, Nov 8, 2010 at 8:37 PM, Haojian Zhuang
>>> > <haojian.zhuang@marvell.com> wrote:
>>> >> From: Zhou Zhu <zzhu3@marvell.com>
>>> >>
>>> >> iwmmx instructions are also used in PJ4. Add PJ4 support.
>>> >>
>>> >> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
>>> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> >> Cc: Eric Miao <eric.y.miao@gmail.com>
>>> > This isn't good. Have to figure out a clean way for this.
>>> >
>>>
>>> How about create new iwmmx.S and pj4-cp0.c? Since it can avoid macro.
>>
>>Could you first explain why the CP15 reg number is different? ?The
>>commit message for the proposed patch does not give any explanation for
>>the difference.
>>
>>
>>Nicolas
>
> Because PJ4 is different from XSC3. "cp 15.0.R15.c1.0" is used for specific control configuration.
>

I think PJ4 is more compliant with the ARMv7 spec, as XSC3 is doing
things a bit differently.

A run-time check of the core will be quicker, but doesn't look like a clean
solution. A better way to go maybe introducing different function entries
which call the common iwmmx handling code.

> Thanks
> Haojian
>

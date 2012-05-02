From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 2 May 2012 13:53:12 +0800
Subject: [PATCH 2/9] ARM: mmp: distinguish mmp and mmp2 in Kconfig
In-Reply-To: <201204272014.49443.arnd@arndb.de>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-3-git-send-email-haojian.zhuang@gmail.com>
 <201204272014.49443.arnd@arndb.de>
Message-ID: <CAN1soZy=OdS=GUc93mgJ0bXTLJSX3+=WuWT=0yLDxkgjjG=wgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 4:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 27 April 2012, Haojian Zhuang wrote:
>> Append four CONFIG_* MACRO to distinguish boards in arch-mmp.
>>
>> CONFIG_MMP_LEGACY and CONFIG_MMP2_LEGACY are used to support boards
>> without device tree.
>>
>> CONFIG_MMP_DT and CONFIG_MMP2_DT are used to support boards with
>> device tree.
>>
>> At the same time, only one of these four macro could be selected.
>> It's used to miss compiling all boards file together.
>
> Can you explain why this is done? It seems counterintuitive to
> have the DT and non-DT support be mutually exclusive.
>
If I selected DT support, I needn't select those machine support one
by one. I want to use
mmp-dt to support all PXA168/PXA910 boards, and use mmp2-dt to support
all mmp2 boards.
So I use exclusive statements in Kconfig for convenience.

Thanks
Haojian

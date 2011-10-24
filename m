From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 24 Oct 2011 20:52:30 +0800
Subject: [GIT PULL] ARM: CSR: l2x0 init cleanup for 3.2
In-Reply-To: <201110072304.48412.arnd@arndb.de>
References: <CAGsJ_4xNqgDSWs-WQCamE592NB_p4r4+sY8-XSrzbkei1jeB7Q@mail.gmail.com>
	<201110072304.48412.arnd@arndb.de>
Message-ID: <CAGsJ_4xu_m7umoohrKSdL2v8reHi9ZdkU7RWo+6a_fCA33e9Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2011/10/8 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 01 October 2011, Barry Song wrote:
>> Since the l2x0 cleanup of prima2 depends on the following two patches
>> in rmk's tree:
>>
>> [1]Rob Herring
>> ARM: 7009/1: l2x0: Add OF based initialization
>> http://www.spinics.net/lists/arm-kernel/msg131123.html
>> it has been in rmk/for-next
>>
>> [2]Barry Song
>> ARM: 7009/1: CACHE-L2X0: filter start address can be 0 and is often 0
>> http://www.spinics.net/lists/arm-kernel/msg140126.html
>> it has been in rmk/for-next
>>
>> I have rebased the l2x0-cleanup branch to "ARM: 7009/1: CACHE-L2X0:
>> filter start address can be 0 and is often 0". this might cause some
>> issues to you. if that is difficult to you, i guess you can pich the
>> commmit and apply it when your tree has been ready.
>>
>> The following changes since commit 513d47a3d953e44d79c29077f6c428a017f8af62:
>> ? Barry Song (1):
>> ? ? ? ? ARM: 7090/1: CACHE-L2X0: filter start address can be 0 and is often 0
>>
>> are available in the git repository at:
>>
>> ? git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git l2x0-cleanup
>
> I think I can keep track of this, but is the commit that you used actually
> from a stable branch in Russell's tree? If that gets rebased, I should
> not pull your patch in.

i have merged rmk/l2x0 branch into prima2 you have merged, can you pull this:

The following changes since commit 1e11bec9b09a28f81dd3173fec6b1c6c56b5e299:
  Barry Song (1):
        Merge branch 'l2x0' of rmk tree into prima2-l2x0

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git prima2-l2x0

Barry Song (2):
      ARM: CSR: call l2x0_of_init to init L2 cache of SiRFprimaII
      ARM: CSR: PM: use outer_resume to resume L2 cache

 arch/arm/boot/dts/prima2-cb.dts |    5 +++-
 arch/arm/mach-prima2/l2x0.c     |   46 +++++++-------------------------------
 arch/arm/mach-prima2/pm.c       |    1 +
 3 files changed, 14 insertions(+), 38 deletions(-)


>
> ? ? ? ?Arnd
>
Thanks
barry

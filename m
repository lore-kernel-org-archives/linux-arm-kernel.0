From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 13 Jun 2011 20:24:27 +0000 (UTC)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<201106121615.24059.arnd@arndb.de>
	<20110612143428.GI10283@n2100.arm.linux.org.uk>
	<201106121701.22418.arnd@arndb.de>
	<20110612153536.GL10283@n2100.arm.linux.org.uk>
Message-ID: <it5rlq$3f0$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> On Sun, Jun 12, 2011 at 05:01:22PM +0200, Arnd Bergmann wrote:
>> Of course it should override the device tree, I'm not arguing that.
>> All I'm saying is that we don't need to special-case this or support
>> both formats once the kernel is there as long as we move the information
>> into appropriate DT-representation of the same data.
>
> You're arguing for it to be parsed by whatever fragment of assembly code
> we have to place around the zImage to merge it into DT.
>
> And yes, it's going to have to be assembly code because we don't have a
> C environment at that point which can run in a relocatable way.

Please, again look at the cuboot stuff which is used on powerpc. It uses
limited C environment: it's executed before kernel entry, so it can use
stack, etc. as setup by the bootloader.


-- 
With best wishes
Dmitry

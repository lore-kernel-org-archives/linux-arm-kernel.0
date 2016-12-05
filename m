From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Dec 2016 15:44:30 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <20161205112043.pyzcbhtu7bklioas@sirena.org.uk>
References: <E1cDo86-0008IX-9W@optimist>
 <20161205112043.pyzcbhtu7bklioas@sirena.org.uk>
Message-ID: <7b3daf13-dbab-5acf-cd5f-2414141500b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/16 11:20, Mark Brown wrote:
> On Mon, Dec 05, 2016 at 07:56:06AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm64 allnodconfig and allmodconfig
> with:
> 
>> 	arm64-allnoconfig
>> ../arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/clear_user.S:53: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/clear_user.S:33: Error: attempt to move .org backwards
>> ../arch/arm64/lib/clear_user.S:53: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_from_user.S:67: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_from_user.S:70: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_from_user.S:67: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_from_user.S:70: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_in_user.S:68: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_in_user.S:71: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_in_user.S:68: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_in_user.S:71: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_to_user.S:66: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_to_user.S:69: Error: bad or irreducible absolute expression
>> ../arch/arm64/lib/copy_to_user.S:66: Error: attempt to move .org backwards
>> ../arch/arm64/lib/copy_to_user.S:69: Error: attempt to move .org backwards
> 
> This was triggered somehow by bca8f17f57bd7 (arm64: Get rid of
> asm/opcodes.h) though I didn't figure out how.

Old and broken gas. I have a workaround stashed there:

http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=arm64/standalone.h&id=559f97365362ed9e96f594200020379df46630d8

At least binutils 2.24 and 2.25 are affected, while 2.27 is not.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

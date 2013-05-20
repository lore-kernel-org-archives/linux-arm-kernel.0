From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 20 May 2013 12:03:41 +0100
Subject: [PATCHv4] arm: Preserve the user r/w register TPIDRURW on context
 switch and fork
In-Reply-To: <51979801.7010903@dawncrow.de>
References: <518AA19B.2020209@dawncrow.de> <51979801.7010903@dawncrow.de>
Message-ID: <519A030D.1030809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andr?

On 18/05/13 16:02, Andr? Hentschel wrote:
> Am 08.05.2013 21:03, schrieb Andr? Hentschel:
>> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
>>

This is strangely formatted for me too, and I use a different client 
from Will so I'm not sure that the problem is just at our end...

(Also see that the list archive has weird formatting:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/167325.html )

Your first couple of patches didn't come out strangely formatted, so I'm 
not really sure what's going on.

>> Since commit 6a1c53124aa1 the user writeable TLS register was zeroed to
>> prevent it from being used as a covert channel between two tasks.
>>
>> There are more and more applications coming to WinRT, Wine could support them,
>> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
>>
>> This patch preserves that register per thread instead of clearing it.
>> Unlike the TPIDRURO, which is already switched, the TPIDRURW
>> can be updated from userspace so needs careful treatment in the case that we
>> modify TPIDRURW and call fork(). To avoid this we must always read
>> TPIDRURW in copy_thread.
>>
>> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>>
>
> Hi,
> I'm not yet very familiar with the development process here,
> am i getting no feedback on v4 because of the mergewindow being closed?
> Or is there another reason? Sry for being impatient.
>

This is a feature, not a fix, so most likely it'll be included at the 
next merge window. For that to happen it should be in Russell's tree 
around the middle of this cycle.

Can you please rebase on 3.10-rc2 (when it happens) and post one more 
version? After that, assuming nobody else has any final comments, you 
could put it in to Russell's patch system...

Just as a hint - one thing you might have done to increase the chances 
of getting comments to clarify what's different between v3 and v4 - as a 
way to make life easier for reviewers you can highlight the differences 
between versions after the "---" (where you currently have the 
description of why there are so many S-o-Bs).

Hope that helps,
Jonny

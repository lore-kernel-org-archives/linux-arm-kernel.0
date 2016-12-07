From: pmladek@suse.com (Petr Mladek)
Date: Wed, 7 Dec 2016 16:19:48 +0100
Subject: [PATCH 0/7] arm: Add livepatch support
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <20161207151948.GE13288@linux.suse>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-12-06 17:06:00, Abel Vesa wrote:
> This is just an idea I've been trying out for a while now. 
> 
> Just in case somebody wants to play with it, this applies to linux-arm/for-next.
> 
> Also please note that this was only tested in qemu, but I will do some testing 
> on some real hardware in the following days.
> 
> FWICT, on this arch the compiler always generates a function prologue somewhere
> between these lines:
> 
> e1a0c00d        mov     ip, sp
> e92ddff0        push    {r4-r9, sl, fp, ip, lr, pc}
> e24cb004        sub     fp, ip, #4
> e24dd064        sub     sp, sp, #100    ; 0x64 <--- local variables
> e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
> ebf9c2c9        bl      80110364 <__gnu_mcount_nc>
> ....
> 
> Every function that follows this pattern (the number of registers pushed and the
> sp subtraction for the local variables being the only acceptable exception) can
> be patched with this mechanism. IIRC, only the inline functions and notrace 
> functions do not follow this pattern.

Please, where do you check that the given function follows this
pattern? I do not have experience with arm at all. But compiler
is able to do crazy optimizations these days.

I think that this was already mentioned somewhere. But please, put
this detailed explanation also to related patch/code so that it
can later be found in the git commits. It will also help to
better understand/review the particular patches.

Best Regards,
Petr

From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Nov 2015 16:58:09 -0600
Subject: [GIT PULL 2/6] ARM: SoC cleanups for v4.4
In-Reply-To: <CA+55aFzUHRvx-=ioeqT-QK+Od6yGixL3q5jit6kD6-Yf5WKXJA@mail.gmail.com>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
 <1447126404-10567-3-git-send-email-olof@lixom.net>
 <CA+55aFzUHRvx-=ioeqT-QK+Od6yGixL3q5jit6kD6-Yf5WKXJA@mail.gmail.com>
Message-ID: <87y4e5sbr2.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Nov 9, 2015 at 7:33 PM, Olof Johansson <olof@lixom.net> wrote:
>>
>> Conflicts:
>>
>> OMAP timer code has a treewide fix vs code deletion conflict. Delete
>> the code in HEAD, go with contents from branch.
>
> That doesn't look right. It also needs the clocksource_of_init ->
> clocksource_probe changes. The code was moved around rather than
> deleted.

correct. Moved from arch/arm/mach-omap2/ to drivers/clocksource/. We're
trying to get all our timer code to drivers/clocksource and make it
DT-only (when all other platforms switch away from legacy boot).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151110/d7212538/attachment.sig>

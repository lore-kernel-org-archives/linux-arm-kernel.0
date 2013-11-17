From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 17 Nov 2013 01:36:52 +0100
Subject: Warning masked by BUG() when CONFIG_BUG is enabled
In-Reply-To: <20131117002651.GX16735@n2100.arm.linux.org.uk> (Russell King's
 message of "Sun, 17 Nov 2013 00:26:51 +0000")
References: <87a9h4559j.fsf@natisbad.org>
 <20131117002651.GX16735@n2100.arm.linux.org.uk>
Message-ID: <8738mvx3rv.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Nov 16, 2013 at 11:52:08PM +0100, Arnaud Ebalard wrote:
>> I was kind of curious not to have noticed it during kernel builds for
>> armada 370/xp targets. The reason is the following: on my Armada 370/XP
>> builds, I had CONFIG_BUG=y which makes BUG() call panic() (which never
>> returns).
>
> You're not the first to spot this, and you won't be the last.
>
> Some very experienced kernel hackers have tried to get this fixed and
> failed.  It seems people actually want the CPU to fall through the
> BUG() sites when people disable CONFIG_BUG - which I think is idiotic.
>
> Arnd (and myself) have worked on this problem, and we came up with a
> very nice solution which didn't increase the size of the kernel and
> didn't make things unsafe.  However, it went nowhere.
>
> It's pointless trying to get this fixed - it's just a complete waste of
> time because of politics.  Find something else to attack.  Just ensure
> you always have CONFIG_BUG enabled if you want a system which will
> produce some kind of report when one of these sites gets hit.

Understood. Thanks for the explanation.

Cheers,

a+

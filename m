From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jul 2012 19:33:24 +0100
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <4FF1E37D.7050103@zytor.com>
References: <4FECB95D.7010200@zytor.com> <20120701104401.GA4352@mail.gnudd.com>
 <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
 <201207021658.27755.arnd@arndb.de>
 <20120702180518.GA25995@sirena.org.uk> <4FF1E37D.7050103@zytor.com>
Message-ID: <20120702183324.GA29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:07:57AM -0700, H. Peter Anvin wrote:

> If there is a dependency there it should be registered, regardless if
> x86 enables the clock API.

Not really, what we *should* have is the clock API available (at least
for build purposes) everywhere.  The current situation where the API is
randomly available on some architectures makes it unusuable in generic
code which is nuts and wasting time and effort, you either need ifdefs
or Kconfig hoop jumping in all the users which isn't at all sane and
means if you're doing anything generic you still need a backup plan.

What should be happening with this is the same as happens with all the
other similar APIs - the API should stub itself out where it's not
provided and the default should be that all architectures use the
generic implementation.  The overwhelming majority of clock API usage is
just enabling the clock only while the device is running to save power
when it isn't which is totally amenable to stubbing out on platforms
that don't support that level of power management.

> Last I saw I saw a patch to that effect, asked what the benefit was, and
> got no answer.

Are you positive about that?  I don't recall you replying any of the
times I sent out the patch and my mail archive isn't contradicting me
either.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/408ce986/attachment.sig>

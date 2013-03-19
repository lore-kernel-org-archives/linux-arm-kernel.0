From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 19 Mar 2013 12:03:34 -0500
Subject: ep93xx irq-vic regression
In-Reply-To: <CACRpkdb9tpeTxEc8A24vTkcUsfd=gQpMub0KpgaKJjrGf-fSvg@mail.gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
 <5143AAB4.6020406@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020980106CB7@AUSP01VMBX24.collaborationhost.net>
 <CACRpkdb9tpeTxEc8A24vTkcUsfd=gQpMub0KpgaKJjrGf-fSvg@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980107047@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 18, 2013 1:22 PM, Linus Walleij wrote:
> On Sat, Mar 16, 2013 at 1:16 AM, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>
>> It looks like the commit above _did_ have a couple bugs but they were
>> fixed:
>
> Oh thanks, I already was scared I had broken something again.
> The irqdomain stuff is a bit fragile, everytime I refactor something
> it blows up in my face. I hope there are no remaining problems.

Linus,

Sorry about not putting you in the loop with this.

The vic driver works fine on the ep93xx. As I stated, there _was_ a
couple bugs in the driver but they have been fixed.

It appears I was chasing a red herring with the vic driver. It ends up that
my system was not booting due to a patch to the ep93xx uncompress.h
header that was causing a deadlock in the early printk support.

This has been fixed and Ryan Mallon has merged the patch into his
ep93xx-fixes branch.

Regards,
Hartley

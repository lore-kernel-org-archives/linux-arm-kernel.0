From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 19 Jul 2017 11:40:08 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <20170719092827.GA28445@n2100.armlinux.org.uk>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
 <20170626101304.GG4902@n2100.armlinux.org.uk>
 <20170626133255.GH8543@e103592.cambridge.arm.com>
 <20170626144001.GH4902@n2100.armlinux.org.uk>
 <AM4PR08MB2659BFF0EAEB020F7571A115D5DF0@AM4PR08MB2659.eurprd08.prod.outlook.com>
 <20170719092827.GA28445@n2100.armlinux.org.uk>
Message-ID: <20170719104006.GF3966@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 10:28:27AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 26, 2017 at 03:14:13PM +0000, Edmund Grimley-Evans wrote:
> > As a user (I recently implemented a work-around for this problem in DynamoRIO: https://github.com/DynamoRIO/dynamorio/commit/0b75c635033d01ab04f955f5affe14a3ced9ab56) I'm happy with any of the proposed solutions, provided that in the "invalid magic number" case user space is not required to regenerate the bogus block with the same invalid magic number when invoking sigreturn.
> 
> I have to ask why a bug report was never sent to kernel people on this.
> If no one tells people that software is buggy, that software stands
> little chance of being fixed!

Partly because I fielded it before it got raised on the list.

However, it would have been good to have more discussion on the list and
to get the DynamoRIO guys commenting on there -- since they are the ones
actually trying to use this feature.

I'll try to encourage that more in the future...

Cheers
---Dave

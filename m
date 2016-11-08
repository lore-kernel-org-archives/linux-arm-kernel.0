From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Nov 2016 23:35:27 +0100
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <20161108164948.GG20591@arm.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <8adfe182-4939-479d-6013-25ec40021b20@huawei.com>
 <20161108164948.GG20591@arm.com>
Message-ID: <2479288.4UmF9SBrq1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 8, 2016 4:49:49 PM CET Will Deacon wrote:
> On Tue, Nov 08, 2016 at 04:33:44PM +0000, John Garry wrote:
> > On 08/11/2016 16:12, Will Deacon wrote:
> > >On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:

> > >Is there no way to make this slightly more generic, so that it can be
> > >re-used elsewhere? For example, if struct extio_ops was common, then
> > >you could have the singleton (which maybe should be an interval tree?),
> > >type definition, setter function and the BUILD_EXTIO invocations
> > >somewhere generic, rather than squirelled away in the arch backend.
> > >
> > The concern would be that some architecture which uses generic higher-level
> > ISA accessor ops, but have IO space, could be affected.
> 
> You're already adding a Kconfig symbol for this stuff, so you can keep
> that if you don't want it on other architectures. I'm just arguing that
> plumbing drivers directly into arch code via arm64_set_extops is not
> something I'm particularly fond of, especially when it looks like it
> could be avoided with a small amount of effort.

Agreed, I initially suggested putting this into arch/arm64/, but there isn't
really a reason why it couldn't just live in lib/ with the header file
bits moved to include/asm-generic/io.h which we already use.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Sep 2014 16:52:15 +0200
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <000b01cfd1a4$f5ae0d20$e10a2760$@samsung.com>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <20140905101409.68b14cc3@bbrezillon>
 <000b01cfd1a4$f5ae0d20$e10a2760$@samsung.com>
Message-ID: <201409161652.15333.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 September 2014, Pankaj Dubey wrote:
> Hi Arnd,  Lee Jones,
> > On Thu, 04 Sep 2014 10:15:27 +0530
> > Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> 
> Any update on this patch. As already it has been tested on two DT based
> platforms.
> 
> If you think that we can go ahead and break clps711x till it gets migrated
> over DT,
> then please ack this patch, or else if you have opinion to keep support for
> non-DT
> based drivers (clps711x) then I can post another patch keeping platform
> driver support
> for non-DT based platform. 

The rule is that we don't intentionally break things, so please post a
patch that keeps the existing platform driver there. Ideally we get a DT-only
clps711x for the merge window as well, and if that happens we can add another
patch on top to remove that syscon-pdev support again but then we will
have a bisectable kernel that works for every point inbetween.


	Arnd

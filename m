From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 25 Apr 2016 13:58:09 +0100
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <4641918.pNBP5iAK01@wuerfel>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
 <20160425103911.GO32731@imgtec.com> <4641918.pNBP5iAK01@wuerfel>
Message-ID: <20160425125809.GP32731@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 01:38:18PM +0200, Arnd Bergmann wrote:
> Maybe say you you found it (llvm, sparse, coccinelle?), and why this
> is causing a problem for anyone. If it's just unnecessary but not
> harmful, I'd probably ignore the patch.

$ grep -rE '(^|\W)const(\s+\w+)+\s+const\s'

I just happened to notice some unnecessary const in our internal code,
so I grep'ed for it in a couple big OSS projects to see how common it
was. Since I found only a few, I decided to remove them, but like I said
it just gets ignored by all the compilers I know, so there's absolutely
no harm in leaving this dead code around.


> That's fine. Having multiple patches here is slightly better than just
> one, but I'd also be fine with just taking the large patch because it
> is an identical trivial change in multiple files.

So, do you want me to split them up? I'd prefer not having to (slightly
less work for me :P), but it doesn't really make much of a difference
either way.

Cheers

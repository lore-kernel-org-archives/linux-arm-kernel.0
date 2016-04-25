From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 25 Apr 2016 15:37:31 +0100
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
 <20160425103911.GO32731@imgtec.com> <4641918.pNBP5iAK01@wuerfel>
 <20160425125809.GP32731@imgtec.com>
 <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
Message-ID: <20160425143731.GR32731@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 10:12:16AM -0400, Nicolas Pitre wrote:
> Beware.
> 
> I added many of those exactly because gcc did not ignore them when 
> compiling with LTO where the lack of a const qualifier to qualify the 
> actual array content, and not only the reference to that content, 
> generated build errors due to section mismatches from the __initconst 
> annotation.

I believe the first `const` does that, without the need for a second.

> So this is a NAK from me unless you may confirm that LTO builds are 
> unaffected by your changes.

I can't confirm it (haven't tried), and don't care enough to do it :]
I guess I'm just dropping the patch then. Like I said, it can't hurt to
leave them in.

Cheers,
Eric

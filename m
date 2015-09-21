From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Sep 2015 00:51:20 +0100
Subject: ARM64 readahead: fault retry breaks mmap file read random
 detection
In-Reply-To: <56007868.8050605@android.com>
References: <1442868028-27055-1-git-send-email-salyzyn@android.com>
 <20150921210938.GC7356@arm.com> <56007868.8050605@android.com>
Message-ID: <20150921235120.GI7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 10:36:40PM +0100, Mark Salyzyn wrote:
> On 09/21/2015 02:09 PM, Will Deacon wrote:
> > On Mon, Sep 21, 2015 at 09:39:50PM +0100, Mark Salyzyn wrote:
> >> Description from commit 45cac65b0fcd
> >>      ("readahead: fault retry breaks mmap file read random detection")
> >> . . .
> >> Yup, arm64 needs this too! Random read improves by 250%, sequential
> >> read improves by 40%, and random write by 400% to an eMMC device with
> >> dm crypto wrapped around it.
> > Thanks for this. This must've gone in whilst we were developing the initial
> > version of the arm64 port and has since gone unnoticed.
> >
> > I'll queue it on the arm64 fixes branch and send a pull request after
> > some testing.
> >
> As noted, this fix may need to be propagated to all the arch-specific 
> code, I was not in a position to check this out on arm (32 bit) and the 
> benchmarking code I used did not immediately port to 32-bit.

You lost me; which arch-specific code are you referring to? The original
patch (in mainline) touches a whole bunch of architectures.

Will

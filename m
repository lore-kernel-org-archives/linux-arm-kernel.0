From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Sep 2017 18:31:13 +0100
Subject: ARM64: kernel panics in DABT in sys_msync path
In-Reply-To: <547ed590-3ab4-cc11-cbea-f587541d2b08@codeaurora.org>
References: <20170924213622.75e7r3k56tgxlezh@yury-thinkpad>
 <20170925105335.GA24042@arm.com>
 <20170925140240.vl5mvbce5lb37dxe@yury-thinkpad>
 <20170925190426.6prpcfn7lly26clm@yury-thinkpad>
 <a3b714ae-97a5-8458-9bf7-140eeeebc4b9@codeaurora.org>
 <20170926102324.GC8693@arm.com>
 <547ed590-3ab4-cc11-cbea-f587541d2b08@codeaurora.org>
Message-ID: <20170926173112.GA16650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury, Richard,

On Tue, Sep 26, 2017 at 08:23:35AM -0600, Ruigrok, Richard wrote:
> On 9/26/2017 4:23 AM, Will Deacon wrote:
> > On Mon, Sep 25, 2017 at 01:54:57PM -0600, Ruigrok, Richard wrote:
> >> I also found this issue with kernels from 4.11 through 4.13.  In my tests, I
> >> found that it reproduces only with 4K page and Transparent Huge Pages. With 64K
> >> page I was not able to reproduce. RH also reported it here: https://
> >> bugzilla.redhat.com/show_bug.cgi?id=1491504 Linaro reported on the RPK kernel
> >> (4.12) on Centriq2400 and ThunderX
> >>  
> >>
> >> https://bugs.linaro.org/show_bug.cgi?id=3191
> >>
> >> https://bugs.linaro.org/show_bug.cgi?id=3068.
> > These two aren't the same bug (that's a forward progress issue that we're
> > currently working on). I don't have permission to look at the redhat one,
> > but is it just an RCU stall or actually the Oops reported by Yury?
> >
> >> I was able to bisect down to a specific commit.
> > I think we're chasing two different things here, so not sure I trust the
> > bisect!
> >
> The RCU stall is side effect.? The issue I'm seeing has the same stack
> trace and same stimulus (rwtest).? Following are the details.

FWIW, I think I've worked out what's going on here and I should have a patch
tomorrow.

Will

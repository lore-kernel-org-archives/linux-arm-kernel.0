From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 11:39:36 +0000
Subject: [PATCH V12 2/7] dma: hidma: Add Device Tree support
In-Reply-To: <569926CF.6030205@codeaurora.org>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-3-git-send-email-okaya@codeaurora.org>
 <20160115151637.GJ3262@leverpostej>
 <20160115153054.GL3262@leverpostej>
 <569926CF.6030205@codeaurora.org>
Message-ID: <20160118113935.GI21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 12:05:19PM -0500, Sinan Kaya wrote:
> On 1/15/2016 10:30 AM, Mark Rutland wrote:
> > Further to my reply below, I'm generally uncomfortable with some
> > properties (max-* need a better description if they are a HW
> > requirement, and probably should not be present otherwise). 
> 
> I'll add more description. 
> 
> > I'm also
> > concerned that information necessary for the advertised use-case of the
> > device (e.g. IOMMUs) is missing [1], and we're missing parts of the
> > story necessary to review this for correctness.
> 
> OK. Let me work on this. I tried to capture as much documentation as possible
> into the series before. One reviewer said I should add it. Another reviewer said I should 
> remove it. 
> 
> Where would be the best place to document the use case? 
> - In the source file?
> - In the commit message?
> - In the device-tree documentation?

Mostly the cover letter, but to varying degrees some information should
appear in the commit messages, documentation, and code.

The cover letter should give a high-level overview sufficient to get
reviewing (e.g. that should point out we expect isolation by IOMMUs).
There should also be pointers to related components (i.e. the QEMU
driver intended to communicate with this).

Things subject to change should go in the cover letter, as it's not
permanent.

If something strongly influences the design in a way that's non-obvious,
then that will probably remain non-obvious. For that, there should
certainly be something in the commit message. If it's something that
will be hit in general usage of the binding (or forms part of the
contract of the binding), that should be described in the binding
documentation.

If there's some caveat other developers need to be aware of, drop a
comment in the code.

Thanks,
Mark.

From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 28 Jul 2010 14:58:00 -0700
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <20100724082334.GB15571@n2100.arm.linux.org.uk>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
	<1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
	<20100724082334.GB15571@n2100.arm.linux.org.uk>
Message-ID: <1280354280.21185.10.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-07-24 at 09:23 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 23, 2010 at 11:58:02AM -0700, Jeff Ohlstein wrote:
> > From: Steve Muckle <smuckle@codeaurora.org>
> > 
> > ScorpionMP does not have the SMP/nAMP mode and TLB ops
> > broadcasting bits in the ACTLR.
> 
> Please provide a separate instance of __v7_proc_info for your processor
> and direct it to jump into the __v7_setup code after this setup instead.


You mean add another label into __v7_setup along with a proc-msm.S to
jump over this code?

Daniel
-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

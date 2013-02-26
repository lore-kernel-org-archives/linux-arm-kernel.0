From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Feb 2013 11:22:01 +0000
Subject: [PATCH v2] arm: plat-samsung: check processor type before
 cache restoration in resume
In-Reply-To: <CAG17yqRS2MxTxgVD0qx73BO0x8PWgCmqrQQ4+rDvP=MwMKj3qw@mail.gmail.com>
References: <1361872613-12040-1-git-send-email-inderpal.singh@linaro.org>
 <20130226100222.GQ17833@n2100.arm.linux.org.uk>
 <CAG17yqRS2MxTxgVD0qx73BO0x8PWgCmqrQQ4+rDvP=MwMKj3qw@mail.gmail.com>
Message-ID: <20130226112201.GR17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 04:46:01PM +0530, Inderpal Singh wrote:
> On 26 February 2013 15:32, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 26, 2013 at 03:26:53PM +0530, Inderpal Singh wrote:
> >> Only cortex-a9 based samsung platforms have l2x0 cache controller. Hence check
> >> the same before restoring the cache in resume.
> >
> > Why is this patch soo complicated?  Can't you read the CPUs MIDR register
> > from assembly code?
> 
> I wanted to read MIDR only once thats why didn't read in resume
> function in assembly as the same resume function gets used in cpuidle
> path.

It's more expensive to load it from memory than to read it from CP15.

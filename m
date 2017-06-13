From: alan@linux.intel.com (Alan Cox)
Date: Tue, 13 Jun 2017 12:48:14 +0100
Subject: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable
 to handle kernel NULL pointer dereference at 00000000000000a8
In-Reply-To: <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
Message-ID: <1497354494.5693.1.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-12 at 17:34 -0600, Logan Gunthorpe wrote:
> Hey,
> 
> Ok, I dug into this bug and I know what's going on. Unfortunately,
> it's
> a mess of a couple issues and I don't know what correct the
> solution(s)
> is(are).
> 
> 1) The test we are looking at is overrunning the dynamic char dev
> major
> numbers by a lot. On a successful run, it gets down to 216 where the
> limit is 234. Thus, there are 18 too many major numbers assigned and
> the
> fact that this test used to work is really just luck. (I've cc'd
> developers from 49db08c3 for this issue.)
> 

If you dump the list of majors and drivers do they all look valid or is
there any corruption or repetition that looks odd (wondering if we've
got too many devices or a leak) ?

Alan

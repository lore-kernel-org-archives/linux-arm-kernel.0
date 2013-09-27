From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Sep 2013 12:23:32 +0100
Subject: [RFT PATCH v1 0/7] enable FPSIMD lazy save and restore for arm64
In-Reply-To: <20130927105045.GA11063@MacBook-Pro.local>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
 <20130927105045.GA11063@MacBook-Pro.local>
Message-ID: <20130927112332.GD9520@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 11:50:46AM +0100, Catalin Marinas wrote:
> On Fri, Sep 27, 2013 at 09:04:40AM +0100, Jiang Liu wrote:
> > From: Jiang Liu <jiang.liu@huawei.com>
> > 
> > This patchset enables FPSIMD lazy save and restore for ARM64, you could
> > apply it against v3.12-rc2.
> > 
> > We have done basic functional tests on ARM fast model, but still lack
> > of detail performance benchmark on real hardware platforms. We would
> > appreciate if you could help to test it on really hardware platforms!
> 
> That's my issue as well, I would like to see some benchmarks before
> merging such patches.

Furthermore, with GCC's register allocator starting to use vector registers to
optimise *integer* code instead of spilling to the stack, it's going to become
more and more common to tasks to have live FP state at context switch. Lazy
switching might simply introduce overhead in the form of additional trapping.

Will

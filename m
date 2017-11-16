From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 18:47:15 +0000
Subject: [PATCH v2 10/18] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <20171116164101.GE94341@samitolvanen.mtv.corp.google.com>
References: <20171116164101.GE94341@samitolvanen.mtv.corp.google.com>
Message-ID: <20171116184714.GD21898@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 08:41:01AM -0800, Sami Tolvanen wrote:
> On Thu, Nov 16, 2017 at 11:50:12AM +0000, Will Deacon wrote:
> > Why don't we just not do LTO if the toolchain is busted?
> 
> Because LTO can not only potentially improve performance, especially
> when combined with PGO (Profile Guided Optimization), but it also
> makes it possible to enable features like Control Flow Integrity that
> can make kernel vulnerabilities more difficult to exploit:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> > This feels like it will end up being a game of whack-a-mole as code
> > could be introduced that tickles known bugs on older toolchains.
> 
> I'm not sure this is much different from dealing with older versions
> of the existing toolchain. Otherwise, we wouldn't need cc-version or
> other similar macros, for example.

I think the big difference is that we have no compelling need to support
older versions of clang or gold.

Will

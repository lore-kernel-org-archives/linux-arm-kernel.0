From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 Sep 2013 16:26:41 -0700
Subject: [GIT PULL] Barrier updates for 3.12
In-Reply-To: <20130812172843.GH25995@mudshark.cambridge.arm.com>
References: <20130812172843.GH25995@mudshark.cambridge.arm.com>
Message-ID: <20130906232641.GG19754@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12, Will Deacon wrote:
> Hi Russell,
> 
> Please pull the following barriers updates for 3.12. This series gives a
> notable performance boost in hackbench benchmarks, and facilitates the use
> of {non,inner}-shareable maintenance and memory barrier operations within
> the kernel.
> 

This patchset seems to have broken the build for people with
older binutils. It looks like gas didn't know about "ish" and
other exotic barrier flavors until the middle of 2010[1]. The
binutils I have that doesn't work is from codesourcery. I don't
know if fixing this is very important though, hopefully people
have moved on to compilers that aren't 3 years old.

 $ ld -v
 GNU ld (Sourcery G++ Lite 2010q1-202) 2.19.51.20090709

[1] http://sourceware.org/git/?p=binutils.git;a=commitdiff;h=b987d0526127b44414de15862e0d46f85e888c73

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

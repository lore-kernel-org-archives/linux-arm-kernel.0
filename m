From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 10:38:17 -0700
Subject: [PATCH 2/9] arm64: Fix INVALID_HWID definition
In-Reply-To: <20140826163134.GH4078@leverpostej>
References: <cover.1408736066.git.geoff@infradead.org>
 <6f84108ac880ef48548208738cbb169fba2fa51a.1408736066.git.geoff@infradead.org>
 <20140826163134.GH4078@leverpostej>
Message-ID: <1409074697.11425.11.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2014-08-26 at 17:31 +0100, Mark Rutland wrote:
> On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > Change the preprocessor macro INVALID_HWID definition from ULONG_MAX to (~0)
> > to allow INVALID_HWID to be used within assembly source files.
> > 
> > Commit 3e98fdacc59bbbdbb659be1a144ccc48ed4860fa (arm64: kernel: make the pen of
> > the secondary a 64-bit unsigned value) added the preprocessor macro INVALID_HWID
> > to asm/cputype.h with it defined to be ULONG_MAX.  Use of INVALID_HWID in an
> > assembly source file that includes cputype.h will generate an assembler
> > undefined symbol ULONG_MAX build error.  The kernel does define a ULONG_MAX in
> > kernel.h, but that file not setup to be included in assembly files.
> 
> We don't seem to be using INVALID_HWID in any assembly at the moment,
> and I'm not sure I follow what we'd need it for.
> 
> Why do we need this in assembly?

We currently don't use INVALID_HWID in any assembly files, but I wanted
to use it for some testing and found the current definition gave an
error.

-Geoff

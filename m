From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 24 Apr 2014 13:41:45 -0500
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <20140424162229.GU26756@n2100.arm.linux.org.uk>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <20140423215040.GC26756@n2100.arm.linux.org.uk> <535926EF.20805@mentor.com>
 <20140424162229.GU26756@n2100.arm.linux.org.uk>
Message-ID: <53595AE9.5000506@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 11:22 AM, Russell King - ARM Linux wrote:
> 
> The obvious question therefore is, if the dynamic linker throws its toys
> out if it encounters a wrong-float-ABI library during a standard library
> search, why would it _not_ throw its toys out on dlsym.  The difference
> in behaviour would to me seem to be a bug - both should behave the same,
> though of course not throwing its toys out, but instead producing an error
> _or_ accepting the difference.  Given that it's an ABI difference,
> rejecting the library is the only sane approach.

The VDSO would appear to not be subject to the same validation that a
file-based DSO is.  I'll dig deeper into this to understand exactly
what's going on, but I have a guess as to why the VDSO happens to work
with armhf userspace: the calling convention is different only for
floating point arguments, and there are none in the VDSO routines.

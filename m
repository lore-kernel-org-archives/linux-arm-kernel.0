From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 15 Apr 2015 19:01:23 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150415153800.GG22741@localhost>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost> <2243754.JW5bGY74bP@wuerfel>
 <20150415153800.GG22741@localhost>
Message-ID: <C342B5CD-D1E2-4364-B99E-C85470A869BB@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 15 Apr 2015, at 17:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Wed, Apr 15, 2015 at 05:15:16PM +0200, Arnd Bergmann wrote:
>> On Wednesday 15 April 2015 11:01:54 Catalin Marinas wrote:
>>> On Wed, Apr 15, 2015 at 11:18:06AM +0200, Dr. Philipp Tomsich wrote:
>>>> We?ve run full systems (built from buildroot) consisting of ILP32 binaries
>>>> only (ok? admittedly gdb was an exception, as we haven?t fixed the fact
>>>> that someone has assumed sizeof(long) == 8 in some data-structure of
>>>> the AArch64 backend there) in our verification runs. In fact, it will be very 
>>>> special classes of applications that will need a 64bit address-space.
>>> 
>>> If we are to merge AArch64-ILP32, I'd like to see a full software stack,
>>> maybe a distro like Debian. Otherwise the kernel code will bit-rot (just
>>> like it regularly happens with big endian).
>> 
>> I actually don't think this should be a prerequisite. We have too many
>> dependencies here, and as long as we are debating the exact ABI,
>> any work that gets put into a full distro support (other than openembedded
>> etc) would likely be wasted.
> 
> I agree with this not being a prerequisite for merging ILP32 but at
> least a long term plan to do something beyond openembedded, once we
> agreed on the ABI and _upstreamed_ the kernel and glibc code. Those
> legacy applications will probably need more than glibc to run and it's
> likely that people will want to run them in a full AArch64 (LP64)
> environment. A simpler approach (to me, I'm not a distro person) would
> be to just provide additional ILP32 libs in a multi-lib arm64 distro
> like Debian rather than all the packages. As for the compiler, AFAIK
> aarch64-linux-gnu-* simply needs an option to build for ILP32.

We?ve had a PPA for Ubuntu 14.04 in the past that included glibc, ncurses, 
termcap, zlib and a few others in a multiarch setup? this was used in the 
field by customers and worked rather well.

One of the engineers in my team is currently working on carrying this forward
so we can use this for any Debian-based AArch64 distribution in the future.

Best,
Phil.

From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 15 Sep 2017 14:29:38 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170915112938.mrkz7ivryctqjnhe@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Linaro has announced the support for ILP32-enabled cross-toolchain:
https://lists.linaro.org/pipermail/linaro-toolchain/2017-September/006247.html

Files:
http://snapshots.linaro.org/components/toolchain/binaries/7.1-2017.08-rc1/aarch64-linux-gnu_ilp32/

Yury

On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-06-16. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> Kernel, GLIBC and OpenSUSE-based distro:
> https://github.com/norov/linux/tree/ilp32-20170616.0
> https://github.com/norov/glibc/tree/dev9
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32

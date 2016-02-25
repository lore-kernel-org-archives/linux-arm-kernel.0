From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 17:28:15 -0800
Subject: [GIT PULL] ARM: Keystone DTS for 4.6
In-Reply-To: <1455959351-11524-1-git-send-email-ssantosh@kernel.org>
References: <1455959351-11524-1-git-send-email-ssantosh@kernel.org>
Message-ID: <20160225012815.GH29055@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 20, 2016 at 01:09:10AM -0800, Santosh Shilimkar wrote:
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.6
> 
> for you to fetch changes up to 5f67dae54262adeb0bfd98fa4c7a9b62548c9f25:
> 
>   ARM: dts: keystone: Add minimum support for K2G evm (2016-02-20 00:56:06 -0800)
> 
> ----------------------------------------------------------------
> ARM: DTS: Add new bindings for K2G and the K2G evm
> 
> K2G SoC family is the newest version of the Keystone family of processors.
> 
> The technical reference manual for K2G can be found here:
> http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf
> ----------------------------------------------------------------
> Nishanth Menon (1):
>       ARM: keystone: Create new binding for K2G SoC
> 
> Vitaly Andrianov (2):
>       ARM: dts: keystone: Add Initial DT support for TI K2G SoC family
>       ARM: dts: keystone: Add minimum support for K2G evm
> 
>  .../devicetree/bindings/arm/keystone/keystone.txt  |  5 ++
>  arch/arm/boot/dts/Makefile                         |  3 +-
>  arch/arm/boot/dts/k2g-evm.dts                      | 32 ++++++++
>  arch/arm/boot/dts/k2g.dtsi                         | 89 ++++++++++++++++++++++
>  arch/arm/mach-keystone/keystone.c                  |  1 +
>  5 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/k2g-evm.dts
>  create mode 100644 arch/arm/boot/dts/k2g.dtsi

We've been asking people to prefix the DTS files with vendor or platform
prefixes, so that the namespace under arch/arm/boot/dts/ somewhat gets
partitioned.

It's really unfortunate that we didn't notice this when the other k2?-* entries
were added, especially since there's a keystone* set of files too.

How do you feel about moving things around and prefixing with keystone*
instead?  We can argue whether users are affected by a rename of already
existing files, or if those can be renamed too. I'll leave that up to you, but
k2? seems like too short a prefix here.


-Olof

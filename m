From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jul 2018 10:17:18 +0100
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
In-Reply-To: <20180715035342.11371-1-olof@lixom.net>
References: <20180715035342.11371-1-olof@lixom.net>
Message-ID: <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 15/07/18 04:53, Olof Johansson wrote:
> There's some use in printing out what the implementer and part numbers
> decode to for cases where they're known.
> 
> I filled in the table based on public information; mostly from ARM TRMs
> and other tools (and some of the SSBD tables in the kernel, etc).
> 
> Apple IDs came from
> https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)

[...]

The same thing pops up every so often. And the answer is the same each time:

- it breaks an existing userspace ABI by changing the format of cpuinfo
- it is unmaintainable in the long run
- userspace already has this information by simply running "lscpu"

What has changed?

	M.
-- 
Jazz is not dead. It just smells funny...

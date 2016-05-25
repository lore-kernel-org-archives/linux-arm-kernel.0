From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Wed, 25 May 2016 11:42:04 +0100
Subject: [PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5745817C.1070406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/16 01:04, Yury Norov wrote:
> This version is based on kernel v4.6.
> It works with glibc-2.23, and tested with LTP.
> 
...
> ILP32 glibc branch is available here:
> https://github.com/norov/glibc/tree/ilp32-2.23
> 
> It is tested with this series with no major downsides. I will send it to 
> glibc-alpha soon, after final revise. Please review and comment it as well.

i spotted one __ilp32__ vs __ILP32__ typo in the glibc code,
i can review it in detail when there is a cleaned up patch set.

in general the approach seems ok, the ugly part is when lp64
and ilp32 share code, but ilp32 needs some tweaks compared to
the current code (e.g. x vs w regs in asm, long changed to
long long in syscalls, different relocations etc) those will
be hard to review. the naming is sometimes _be_ilp32 sometimes
ilp32_be, but let's hope there will be no new abi variant to
confuse this further.

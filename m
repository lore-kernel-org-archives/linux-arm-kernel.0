From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 17 Mar 2017 11:43:11 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <1489750991.17202.40.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-15 at 18:56 +0900, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
> 
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> For your convinience, you can pick them up from:
> ?? https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git?arm64/kdump
> ?? https://git.linaro.org/people/takahiro.akashi/kexec-tools.git?arm64/kdump
> 
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> ? - crash utility (v7.1.8 or later) [3]
> 
> I tested this patchset on fast model and hikey.

Is this one going to be be my fault too?

[???38.947305] SMP: stopping secondary CPUs
[???38.951291] Starting crashdump kernel...
[???38.955207] ------------[ cut here ]------------
[???38.959818] WARNING: CPU: 0 PID: 312 at arch/arm64/kernel/machine_kexec.c:169 machine_kexec+0x220/0x298

That's the cpus_are_stuck_in_kernel() || num_online_cpus() one. Again,
v32 applied to a 4.9 kernel. With the stray __init removed this time ;)

Taking secondary CPUs down for a normal kexec does work via PSCI.

I'll see if I can enable enough hardware support to let me test a newer
kernel...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/d019a5cd/attachment.bin>

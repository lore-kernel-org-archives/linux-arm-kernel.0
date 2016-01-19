From: dyoung@redhat.com (Dave Young)
Date: Tue, 19 Jan 2016 20:32:30 +0800
Subject: [PATCH 00/19] arm64 kexec kernel patches v13
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/16 at 07:18pm, Geoff Levand wrote:
> This series adds the core support for kexec re-boot and kdump on ARM64.  This
> version of the series combines Takahiro's kdump patches with my kexec patches.
> Please consider all patches for inclusion.
> 
> I just tested all the endian combinations of kexec LE->LE, LE->BE, BE->BE,
> BE->LE, and both LE an BE kdump, and all work as expected.
> 
> To load a second stage kernel and execute a kexec re-boot or to work with kdump
> on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> merged upstream, are needed.
> 
> To examine vmcore (/proc/vmcore), you should use
>   - gdb v7.7 or later
>   - crash v7.1.1 or later
> 
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
> 

Geoff, another question about kexec-tools part is, can the kexec-tools code
been written in kernel? We have the infrastructure for kexec_file_load.

In the future if we have to support loading a signed kernel then we still
need to do that, but we may have to support both the kexec-tools and the
in kernel loader for compatibility purpose. It will be hard to maintain.

Thanks
Dave

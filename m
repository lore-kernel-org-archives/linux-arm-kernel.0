From: geoff@infradead.org (Geoff Levand)
Date: Tue, 30 Sep 2014 14:27:56 -0700
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <20140930202904.GB24153@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20140930202904.GB24153@redhat.com>
Message-ID: <1412112476.6630.56.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, 2014-09-30 at 16:29 -0400, Vivek Goyal wrote:
> On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> 
> [..]
> > To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> > kexec-tools [2], which have not yet been merged upstream, are needed.
> > 
> > This series does not include some re-work of the spin-table CPU enable method
> > that is needed to support it,
> 
> How do I figure out if my system has spin table enable method or psci
> enable method. Can one change it. I wanted to test your patches.

The enable method is a function the firmware/bootloader provides.
Multiple methods may be supported.  The boot-wrapper-aarch64
build defaults to spin-table, but has the configure option --enable-psci.

For a running system you can check the device tree:

  cat /proc/device-tree/cpus/cpu\@0/enable-method | hexdump -C

Or the dmsg:

  dmesg | egrep -i 'psci'

Or use the --debug option to kexec:

  kexec --debug --load /boot/vmlinux.strip ...

read_cpu_info:398: cpu-0 (/cpus/cpu at 0): hwid-0, 'psci'

-Geoff

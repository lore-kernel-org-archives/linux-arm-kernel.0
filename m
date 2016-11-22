From: geoff@infradead.org (Geoff Levand)
Date: Tue, 22 Nov 2016 10:56:59 -0800
Subject: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
In-Reply-To: <cover.1479788404.git.panand@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
Message-ID: <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
> is around 13MB and initramfs is around 30MB. It takes more than 20 second
> even when we have -O2 optimization enabled. However, if dcache is enabled
> during purgatory execution then, it takes just a second in SHA verification.

As I had mentioned in another thread, I think -O2 optimization is
sufficient considering the complexity of the code needed to enable
the dcache.  Integrity checking is only needed for crash dump
support.  If the crash reboot takes an extra 20 seconds does it
matter?

For the re-boot of a stable system where the new kernel is loaded
then immediately kexec'ed into integrity checking is not needed.
For that arm64 support needs to be added to kexec-lite.

-Geoff

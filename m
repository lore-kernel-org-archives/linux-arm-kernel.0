From: panand@redhat.com (Pratyush Anand)
Date: Wed, 23 Nov 2016 07:09:53 +0530
Subject: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
In-Reply-To: <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
References: <cover.1479788404.git.panand@redhat.com>
 <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
Message-ID: <3b5b6613-acb2-0888-a78c-6da69c1b55e0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Wednesday 23 November 2016 12:26 AM, Geoff Levand wrote:
> Hi Pratyush,
>
> On 11/21/2016 08:32 PM, Pratyush Anand wrote:
>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz
>> image
>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>> even when we have -O2 optimization enabled. However, if dcache is enabled
>> during purgatory execution then, it takes just a second in SHA
>> verification.
>
> As I had mentioned in another thread, I think -O2 optimization is
> sufficient considering the complexity of the code needed to enable
> the dcache.  Integrity checking is only needed for crash dump
> support.  If the crash reboot takes an extra 20 seconds does it
> matter?
>

Even this 20 second for kdump case is also annoying and this could 
increase if the size of initramfs increases.

Moreover, by default d-cache is still disabled, so even if it is complex 
and you might see some instability, it will not affect the existing 
systems. So, IMHO we should have this in the upstream.


> For the re-boot of a stable system where the new kernel is loaded
> then immediately kexec'ed into integrity checking is not needed.
> For that arm64 support needs to be added to kexec-lite.

I think kexec-lite is a separate project and --lite in kexec-tools was 
never acked. So, even for `kexec -l` it will be helpful.

~Pratyush

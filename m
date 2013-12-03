From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Dec 2013 18:38:44 +0000
Subject: [PATCH 1/3] arm64: add EFI stub
In-Reply-To: <1385762712-17043-2-git-send-email-msalter@redhat.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-2-git-send-email-msalter@redhat.com>
Message-ID: <20131203183844.GA22668@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Roy,

On Fri, Nov 29, 2013 at 10:05:10PM +0000, Mark Salter wrote:
> This patch adds PE/COFF header fields to the start of the Image
> so that it appears as an EFI application to EFI firmware. An EFI
> stub is included to allow direct booting of the kernel Image. Due
> to EFI firmware limitations, only little endian kernels with 4K
> page sizes are supported at this time. Support in the COFF header
> for signed images was provided by Ard Biesheuvel.

I haven't really jumped into this but, whilst I see the use of EFI_STUB on
both arm and arm64, there seems to be some duplication/reinvention between
the two series you've put together.

Maybe I'm just being ignorant, but the stuff in efi-stub.c really looks to
be doing the same thing on both architectures. Would you guys be able to
work to together to produce an independent series containing the common
parts, then add arm/arm64 backends on top of that please? In particular,
factoring out the device-tree parts ensures that we don't introduce subtle
differences between the two architectures when there's no real need to do
so...

...or shout at me because I didn't understand what you were doing!

Cheers,

Will

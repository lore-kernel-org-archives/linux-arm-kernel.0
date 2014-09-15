From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 14 Sep 2014 20:37:53 -0700
Subject: [PATCH 1/2] ARM: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <CAKv+Gu-MAkzFtrFk19mYB=jQyLsFLY+k3Ly=eZQ=3hWSALLRPw@mail.gmail.com>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
 <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
 <CAKv+Gu8J8o2=CS9tGVbkavHep6gNwSSegZ0fxqsVE2AVDVzdpA@mail.gmail.com>
 <20140913170638.GA3348@lvm>
 <CAKv+Gu93FkRWXd96gKdN+OCrUgjF0sXWL4ohishVWAO-XeR9Ww@mail.gmail.com>
 <fdc415c79e617d4e9102acc12a4c0d65@www.loen.fr>
 <CAKv+Gu-kce_1cg2fgj5Qj_kRMtzzHctofZ108531-UrcFLZAog@mail.gmail.com>
 <CAKv+Gu-MAkzFtrFk19mYB=jQyLsFLY+k3Ly=eZQ=3hWSALLRPw@mail.gmail.com>
Message-ID: <CAFEAcA_TDxQj+9pfObJdsr_ubcNnv-OOEy5=a46YaVsQhEy7gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2014 15:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> So, in summary, there is a concern that a malicious guest may request
> a cachable mapping for a device range, in an attempt to manipulate the
> VGIC or other device memory of another VM.
> I think that concern only applies to writable mappings

I think it also applies to read-only mappings, because it would
still be permitting the guest to set up a situation with mismatched
memory attributes with potentially unpleasant effects for the
other guest (which no longer gets the guarantees it should
get from the fact it has mapped the VGIC as Device memory).

thanks
-- PMM

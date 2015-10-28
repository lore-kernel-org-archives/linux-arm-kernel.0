From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 11:28:39 +0000
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <56302F42.4040408@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <56302E7C.7000605@codeaurora.org>
 <CAKv+Gu9t=dGoaVem+h11cXfimpEzmte36_j4tKW_h8rA8c1jBg@mail.gmail.com>
 <56302F42.4040408@codeaurora.org>
Message-ID: <20151028112839.GA24930@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 09:13:22PM -0500, Timur Tabi wrote:
> Ard Biesheuvel wrote:
> >No. I screwed up the patch since the trailing ) should not be there,
> >but we do need to round first, and only then add the offset.
> 
> But if the offset is not a multiple of 2MB, won't the address passed
> to allocate_pages be unaligned?  I'll test your patch on our system,
> but I thought the problem was that the allocated address must be
> aligned.

The kernel needs to be loaded at an address which is text_offset bytes
past a 2M-aligned base. It is not loaded at the 2M-aligned base itself.

Ard's patch correctly findd a 2M-aligned base, then adds the text
offset.

Mark.

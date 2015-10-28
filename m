From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 27 Oct 2015 21:13:22 -0500
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <CAKv+Gu9t=dGoaVem+h11cXfimpEzmte36_j4tKW_h8rA8c1jBg@mail.gmail.com>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <56302E7C.7000605@codeaurora.org>
 <CAKv+Gu9t=dGoaVem+h11cXfimpEzmte36_j4tKW_h8rA8c1jBg@mail.gmail.com>
Message-ID: <56302F42.4040408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel wrote:
> No. I screwed up the patch since the trailing ) should not be there,
> but we do need to round first, and only then add the offset.

But if the offset is not a multiple of 2MB, won't the address passed to 
allocate_pages be unaligned?  I'll test your patch on our system, but I 
thought the problem was that the allocated address must be aligned.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 27 Oct 2015 21:10:04 -0500
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
Message-ID: <56302E7C.7000605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel wrote:
> +               *image_addr = *reserve_addr = round_up(dram_base, SZ_2M) +
> +                                                      TEXT_OFFSET);

Shouldn't this be:

*image_addr = *reserve_addr = round_up(dram_base + TEXT_OFFSET, SZ_2M);

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

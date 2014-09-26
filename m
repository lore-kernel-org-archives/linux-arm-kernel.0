From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 26 Sep 2014 11:39:18 +0100
Subject: [PATCH] arm/arm64: KVM: Report correct FSC for unsupported fault
 types
In-Reply-To: <1411727573-1346-1-git-send-email-christoffer.dall@linaro.org>
References: <1411727573-1346-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA9+bPpnJf24JXcrEaWeLHS48vTWVAMQm05OsuSkX+wr+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 September 2014 11:32, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> When we catch something that's not a permission fault or a translation
> fault, we log the unsupported FSC in the kernel log, but we were masking
> off the bottom bits of the FSC which was not very helpful.
>
> Also correctly report the FSC for data and instruction faults rather
> than telling people it was a DFCS, which doesn't exist in the ARM ARM.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

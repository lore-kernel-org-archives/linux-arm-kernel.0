From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 12:45:09 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
Message-ID: <56B24AB5.3070001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> As you know I have made the pre-timeout support patch, If people like
> it, i am happy to go on upstream it separately.
>
> If we want to use pre-timeout here, user only can use get_pretimeout
> and disable panic by setting pretimeout to 0
> but user can not really set pretimeout, because "pre-timeout  ==
> timeout / 2 (always)".
> if user want to change pretimeout, he/she has to set_time instead.

Ok, I think patches 4 and 5 should be combined, and I think the Kconfig 
entry should be removed and just use panic_enabled.

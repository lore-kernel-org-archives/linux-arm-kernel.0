From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 25 Aug 2016 15:31:22 +0200
Subject: [PATCH] arm64: KVM: Save two instructions in __guest_enter()
In-Reply-To: <1470791736-13949-1-git-send-email-shankerd@codeaurora.org>
References: <1470791736-13949-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20160825133122.GA8016@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On Tue, Aug 09, 2016 at 08:15:36PM -0500, Shanker Donthineni wrote:
> We are doing an unnecessary stack push/pop operation when restoring
> the guest registers x0-x18 in __guest_enter(). This patch saves the
> two instructions by using x18 as a base register. No need to store
> the vcpu context pointer in stack because it is redundant and not
> being used anywhere, the same information is available in tpidr_el2.

Does this have any measureable benefit?

Thanks,
-Christoffer

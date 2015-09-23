From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 23 Sep 2015 14:21:16 -0500
Subject: [PATCH 2/6] arm64: Convert hcalls to use HVC immediate value
In-Reply-To: <f1d72f4782ef5185626a012872f9ebefe057c7e8.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
 <f1d72f4782ef5185626a012872f9ebefe057c7e8.1426793116.git.geoff@infradead.org>
Message-ID: <CAOZdJXUNhGk59vEnAhXBUun2ieiuUfYH=GKmeB4-wK=azv5HBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 3:35 PM, Geoff Levand <geoff@infradead.org> wrote:
> The existing arm64 hcall implementations are limited in that they only allow
> for two distinct hcalls; with the x0 register either zero or not zero.  Also,
> the API of the hyp-stub exception vector routines and the KVM exception vector
> routines differ; hyp-stub uses a non-zero value in x0 to implement
> __hyp_set_vectors, whereas KVM uses it to implement kvm_call_hyp.
>
> To allow for additional hcalls to be defined and to make the arm64 hcall API
> more consistent across exception vector routines, change the hcall
> implementations to use the 16 bit immediate value of the HVC instruction to
> specify the hcall type.
>
> Define three new preprocessor macros HVC_CALL_HYP, HVC_GET_VECTORS, and
> HVC_SET_VECTORS to be used as hcall type specifiers and convert the
> existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp() routines
> to use these new macros when executing an HVC call.  Also, change the
> corresponding hyp-stub and KVM el1_sync exception vector routines to use these
> new macros.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

What is the status of this patch?  I see it's not in 4.2.  I ask
because this patch might be breaking our 4.2-based kernel, and I'm
just wondering if it's still applicable.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

From: geoff@infradead.org (Geoff Levand)
Date: Tue, 02 Sep 2014 09:18:34 -0700
Subject: [RFC PATCH v1] Arm64: introduce __hyp_func_call
In-Reply-To: <1409668765-25567-1-git-send-email-achandran@mvista.com>
References: <1409668765-25567-1-git-send-email-achandran@mvista.com>
Message-ID: <1409674714.21254.115.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, 2014-09-02 at 20:09 +0530, Arun Chandran wrote:
> This adds a mechanism to __hyp_stub_vectors to allow a hypercall to
> call a function at EL2. It is needed for users who want to
> run a part of code with EL2 permissions. The current usecase is for
> KVM and kexec.
> 
> For kexec we need to move the final CPU up to the mode it started
> in before we branch to the new kernel. If we don't do that

I certainly appreciate you trying to help with the kexec work, but I
already have a patch that does something similar to this in my kexec
series [1].

Also, I think we need to consider this change in the context of the
entire solution around how we handle exception level and kexec + KVM.
I'm now working through the details of that, and when I have something I
think is acceptable I'll post the kexec series for review.

[1] https://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff

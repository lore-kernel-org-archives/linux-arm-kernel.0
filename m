From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 5 Sep 2013 15:51:04 +0100
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2013 15:45, Anup Patel <anup.patel@linaro.org> wrote:
> It will be very useful for user space if it has a method for specifying
> KVM ARM/ARM64 to give a VCPU with target type suitable to underlying host
> but with particular set of features.
>
> In other words, user space might not be interested in having a particular
> target type for VCPU but it will certainely want particular set of features
> in the VCPU.
>
> The patch tries to implement above described method of specifying VCPU
> target CPU=Host from user space by extending the KVM_ARM_VCPU_INIT ioctl
> and having a dummy target KVM_ARM_TARGET_HOST which means Target CPU
> same as (or suitable to) underlying host.

I thought the consensus on the call last week was
to have an ioctl for "get best CPU for this host"
and then for userspace to pass that value to
VCPU_INIT ?

-- PMM

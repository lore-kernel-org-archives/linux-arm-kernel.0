From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 9 Oct 2013 11:15:03 +0900
Subject: [PATCH] ARM: KVM: drop arbitrary limitation to 4 CPU VMs
In-Reply-To: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
References: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAFEAcA8vgfyEDhYDYDZc16pgdtFOYe-djWcbB0qh6Hrv7X=-PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2013 02:17, Marc Zyngier <marc.zyngier@arm.com> wrote:
> It appears we have an arbitrary limitation where we refuse to
> create more than 4 virtual A15 in a single VM.
>
> This limitation doesn't make much sense (the number 4 probably
> comes from the maximum number of CPUs in a A15 cluster, but
> KVM doesn't have any notion of cluster)

"Don't allow configurations that can't exist in hardware" makes
sense as a restriction to me... QEMU will also enforce the 4-cpu
limit.

-- PMM

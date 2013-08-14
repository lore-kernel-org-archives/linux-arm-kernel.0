From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 14 Aug 2013 16:35:13 +0100
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <5d2d3ae495c27873661c5c2fbdcc19b6@www.loen.fr>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <5d2d3ae495c27873661c5c2fbdcc19b6@www.loen.fr>
Message-ID: <CAFEAcA_d-rtiJoAZhGN=cggzakJ5QzU6Upg1GUSBgUOSuqPZoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2013 16:23, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 2013-08-14 15:22, Anup Patel wrote:
>> It seems a bit unnatural to have cache cleaning is user-space. I am
>> sure
>> other architectures don't have such cache cleaning in user-space for
>> KVM.
>
> Well, we have it on AArch64. Why would we blindly nuke the whole cache
> if we can do the right thing, efficiently, on the right range?

When exactly would userspace have to care about the cache?
This patch isn't exactly clear about the circumstances. I
think you'd need a really strong reason for not dealing with
this in the kernel -- in general userspace KVM tools don't
otherwise have to deal with cache maintenance at all.

-- PMM

From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 17 Mar 2016 20:08:37 -0700
Subject: [GIT PULL] arm64 updates for 4.6
In-Reply-To: <20160317182651.GA32292@e104818-lin.cambridge.arm.com>
References: <20160317182651.GA32292@e104818-lin.cambridge.arm.com>
Message-ID: <CA+55aFyZ62re_a8ko=001zMt2eFsKptsExX2bhfxf4Ebo8Yvyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 11:26 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Here are the main arm64 updates for 4.6. There are some relatively
> intrusive changes to support KASLR, the reworking of the kernel virtual
> memory layout and initial page table creation. These would conflict with
> some of the arm64 KVM changes merged via the KVM tree (adding support
> for the "Virtualisation Host Extensions" ARMv8.1 feature). The prior
> merge resolution in linux-next should be fine but I also included the
> output of "git show --cc" on a local merge I did against last night's
> mainline tree (at the end of this email). If there are any issues please
> let me know.

I think I got the same merge resolution except for the ordering of the
arm64_features[] table, where I made ARM64_HAS_VIRT_HOST_EXTN go after
ARM64_ALT_PAN_NOT_UAO, the way it is numbered. That shouldn't matter.

But since I don't do cross builds or test arm64, you should
double-check that I didn't screw something up. (it's not pushed out
quite yet, since my build is still going, but it should be out
soonish)

Thanks,

              Linus

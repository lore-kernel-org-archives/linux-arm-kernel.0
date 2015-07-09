From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 9 Jul 2015 11:53:23 +0200
Subject: [PATCH v8 00/11] KVM Guest Debug support for arm64
In-Reply-To: <1436286603-15192-1-git-send-email-alex.bennee@linaro.org>
References: <1436286603-15192-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150709095323.GF13530@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 05:29:52PM +0100, Alex Benn?e wrote:
> Here is V8 of the KVM Guest Debug support for arm64.
> 
> The diffstat between v7 and v8 is getting pretty small and as I
> haven't re-based you can run:
> 
>         git diff -u guest-debug/4.1-v7..guest-debug/4.1-v8
> 
> And the kernelci report is at:
> 
>         http://kernelci.org/build/alex/kernel/v4.1-11-g182a5fa64600/
> 
> 
> The only real changes apart from comments and white space are to
> sys_regs which sees another minor re-factoring. The 32 bit handling
> explicitly preserves the top 32 bits of the AArch64 registers although
> I'm not convinced it matter too much as for a booting AArch32 guest
> kernel they should start as 0 and never change.
> 
> For full details see the changelog on each of the patches.
> 
> GIT Repos:
> 
> The patches for this series are based off v4.1 and can be found
> at:
> 
> Kernel:
> https://git.linaro.org/people/alex.bennee/linux.git
> branch: guest-debug/4.1-v8
> describe: v4.1-11-g182a5faB
> 
> QEMU:
> https://github.com/stsquad/qemu
> branch: kvm/guest-debug-v6*** BLURB HERE ***
> 
> 
I'm happy with this series as it stands now and think it can be put into
-next.

I have boot-tested the series with a VM on both Juno and TC2.

Thanks,
-Christoffer

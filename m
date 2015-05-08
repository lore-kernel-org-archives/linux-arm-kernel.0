From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 May 2015 18:33:05 +0200
Subject: [PATCH v3 00/12] KVM Guest Debug support for arm64
In-Reply-To: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150508163305.GJ24744@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 05:23:15PM +0100, Alex Benn?e wrote:
> Hi,
> 
> Here is V3 of the KVM Guest Debug support for arm64.
> 
> This sees the return of hyp.S re-factoring code which has been
> expanded to handle both the save and restore legs. The HW debug patch
> then adds a simple indirection to enable switching between the guest
> context debug registers and the active debugging context.
> 
> The API has been further simplified to remove the PC (as that is
> already available by the GET_ONE_REG ioctl). The responsibility for
> handling re-injection is now explicitly that of userspace.
> 
> The setup/clear debug code has gained an init function to be called at
> start-up and save useful values (currently only mdcr_el2.HPMN).
> 
> For full details see the changelog on each of the patches.
> 
> As before there are a few checkpatch violations for white space. Some
> in existing code (asm-offsets) and a couple in the handle_exit code
> where adding a whole extra tab seemed excessive.
> 
> Reviewed-by tags have been added to the earlier patches as
> appropriate.
> 
> GIT Repos:
> 
> The patches for this series are based off v4.1-rc1 and can be found
> at:
> 
> https://git.linaro.org/people/alex.bennee/linux.git
> branch: guest-debug/4.1-rc1-v3
> 

This doesn't seem to build for 32-bit ARM :(

-Christoffer

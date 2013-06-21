From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 16:41:51 -0600
Subject: [PATCH V2 1/2] kexec: return error of machine_kexec() fails
In-Reply-To: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51C4D6AF.9010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 02:01 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Prior to commit 3ab8352 "kexec jump", if machine_kexec() returned,
> sys_reboot() would return -EINVAL. This patch restores this behaviour
> for the non-KEXEC_JUMP case, where machine_kexec() is not expected to
> return.
> 
> This situation can occur on ARM, where kexec requires disabling all but
> one CPU using CPU hotplug. However, if hotplug isn't supported by the
> particular HW the kernel is running on, then kexec cannot succeed.

Eric, does this look reasonable to go into 3.11? Thanks.

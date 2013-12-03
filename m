From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 13:04:12 -0700
Subject: [PATCH] ARM: tegra: convert device tree files to use key defines
In-Reply-To: <1385989797-10879-1-git-send-email-ldewangan@nvidia.com>
References: <1385989797-10879-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <529E393C.4010604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 06:09 AM, Laxman Dewangan wrote:
> Use key code macros for all key code refernced for keys.
> 
> For tegra20-seaboard.dts and tegra20-harmony.dts:
>   The key comment for key (16th row and 1st column) is KEY_KPSLASH but
>   code is 0x004e which is the key code for KEY_KPPLUS. As there other
>   key exist with KY_KPPLUS, I am assuming key code is wrong and comment
>   is fine. With this assumption, I am keeping the key code as KEY_KPSLASH.

This looks reasonable, and I'll apply it soon. What is the patch based
on? Note that I recently sent a patch to fix the sort order of DT nodes
in all Tegra DT files, which I'll apply early since it's a cleanup, and
IIRC some of the KBC nodes may have been moved by that patch, so this
may conflict. I'll see if I can rebase while applying it.

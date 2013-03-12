From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 13:32:59 -0600
Subject: [PATCH V2 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <1363060916-8897-1-git-send-email-josephl@nvidia.com>
References: <1363060916-8897-1-git-send-email-josephl@nvidia.com>
Message-ID: <513F82EB.1030407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:01 PM, Joseph Lo wrote:
> This series introduces a basic functionality for Tegra to support the
> platform suspend and resume.
> 
> Note: This series only adds the support for Tegra20 and Tegra30. The
> Tegra114 will be supported later.

Aside from the few issues that have already been pointed out, this looks
OK now. I have a couple questions:

1) Please remind me if this series depends on anything. If not, I hope
to apply it mostly directly on top of 3.9-rc1 or so.

2) You mentioned that Tegra114 isn't supported. What is the failure mode
on Tegra114? Is suspend simply not available and hence can't be
requested, or will suspend attempts gracefully return an error, or will
there we crashes, boot failures, etc.?

3) Sorry for asking this again, but since only LP2 is actually
implemented in patch 4, what happens if the user selects LP0 or LP1?
Does the system (a) just use LP2, (b) fail to suspend, and hence
immediately resume, (c) suspend, but can't be resumed, ...?

Thanks.

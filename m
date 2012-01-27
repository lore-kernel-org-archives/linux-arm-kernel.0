From: olof@lixom.net (Olof Johansson)
Date: Fri, 27 Jan 2012 00:19:12 -0800
Subject: [PATCH v1 1/8] ARM: tegra: introduce support for reading chipid
In-Reply-To: <1327597641-7519-2-git-send-email-pdeschrijver@nvidia.com>
References: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
 <1327597641-7519-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120127081912.GA13387@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 26, 2012 at 07:07:06PM +0200, Peter De Schrijver wrote:
> Introduce a function to read the Tegra chipid. This will be used by the SMP
> code to distinguish between Tegra variants.
> 
> ---
> 
> Should this be merged with the fuse reading code even though this is a
> hardwired register, not a fuse based register?

Well, it's part of a register that the fuse code already reads, i.e. in
tegra_get_revision(). I'd say add it there instead of create a separate
file for it.

There's actually an opencoded version of this in that very function
already that can be cleaned up at the same time (to check for A03p vs
A03 revisions).


-Olof

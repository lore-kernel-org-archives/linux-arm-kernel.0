From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Nov 2018 18:00:42 +0000
Subject: [PATCH] arm64: Build vDSO with -ffixed-x18
In-Reply-To: <20181107003913.19061-1-pcc@google.com>
References: <20181107003913.19061-1-pcc@google.com>
Message-ID: <20181108180041.GG144107@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 04:39:13PM -0800, Peter Collingbourne wrote:
> The vDSO needs to be build with x18 reserved in order to accommodate
> userspace platform ABIs built on top of Linux that use the register
> to carry inter-procedural state, as provided for by the AAPCS.
> An example of such a platform ABI is the one that will be used by an
> upcoming version of Android.
> 
> Although this change is currently a no-op due to the fact that the vDSO
> is currently implemented in pure assembly on arm64, it is necessary
> in order to prepare for another change [1] that will add C code to
> the vDSO.

Since this is a no-op for the current kernel, I guess Vincenzo (cc'ed)
will pick it up as he's planning to post an update to the vDSO in C
series soon.

-- 
Catalin

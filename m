From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 9 Apr 2014 14:40:24 +0200
Subject: [PATCH 2/2] net: mvneta: fix usage as a module on RGMII
 configurations
In-Reply-To: <20140409122241.GE1160@arch.cereza>
References: <1395789942-20764-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395789942-20764-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <533C1B75.2020803@free-electrons.com>
 <20140403113652.33f11413@skate> <20140409122241.GE1160@arch.cereza>
Message-ID: <20140409144024.0d0e5151@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 9 Apr 2014 09:22:41 -0300, Ezequiel Garcia wrote:

> Just found this commit is in v3.12.17 and prevents booting the A370
> Mirabox with nfsroot.
> 
> Maybe we should revert it in stable for now until we can solve it?
> 
> Unless you have a better idea.

Yes, this problem is already tracked at
https://bugzilla.kernel.org/show_bug.cgi?id=73401, where I've explained
what's going on.

Unfortunately, I'm still waiting for details from Marvell to understand
in which cases the PCS needs to be set, and in which situations it
needs to be cleared.

Since getting this information is apparently going to take much more
time that I originally hoped, I'm starting to think that the safest and
fastest course of action is indeed to revert this patch.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

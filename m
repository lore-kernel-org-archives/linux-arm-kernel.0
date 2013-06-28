From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 28 Jun 2013 17:26:00 +0400
Subject: [PATCH 00/06] ARM: shmobile: Remove unused auxdata tables
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
Message-ID: <51CD8EE8.7090506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-06-2013 14:29, Magnus Damm wrote:

> ARM: shmobile: Remove unused auxdata tables

> [PATCH 01/06] ARM: shmobile: Remove unused EMEV2 auxdata table
> [PATCH 02/06] ARM: shmobile: Remove unused r8a7740 auxdata table
> [PATCH 03/06] ARM: shmobile: Remove unused r8a7778 auxdata table
> [PATCH 04/06] ARM: shmobile: Remove unused r8a7779 auxdata table
> [PATCH 05/06] ARM: shmobile: Remove unused sh7372 auxdata table
> [PATCH 06/06] ARM: shmobile: Remove unused sh73a0 auxdata table

> Rework the mach-shmobile code to pass NULL to of_platform_populate()
> instead of empty lists. This cleans up the code and reduces the
> number of lines. The recently added SoCs r8a7790 and r8a73a4 are
> already following this style, so no need to touch them.

    Right, these tables will actually be needed in the board code 
instead, e.g. for Ether. Although, for the USB devices we might still 
need them where they are, once these devices are described in DT.
Dilemma... I suspect we might be too hasty with this patch.

WBR, Sergei

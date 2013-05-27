From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 27 May 2013 15:53:19 +0200
Subject: VDSO for arm 32bit
In-Reply-To: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
Message-ID: <20899.25935.838288.45383@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar, Ganesh writes:
 > Hi All,
 > 
 > ? I'm working on OMAP5 on greg's LTS kernel 3.4.25, but I see there is
 > no support for vdso for arm 32 bit.
 > I'm planning to port it to arm 32 bit, is there any work under progress?
 > would like to understand why the support for arm 32 bit is not there, any idea?

32-bit ARM has a "kuser" page at a fixed virtual address, which exports a
few critical routines to user-space.  With that, a vdso is mostly redundant.

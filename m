From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Mar 2013 16:23:45 +0900
Subject: [PATCH v4 2/3] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <20130301014148.GB9232@quad.lixom.net>
References: <201302272339.15402.sergei.shtylyov@cogentembedded.com>
 <20130301014148.GB9232@quad.lixom.net>
Message-ID: <20130301072345.GD14376@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 05:41:48PM -0800, Olof Johansson wrote:
> On Wed, Feb 27, 2013 at 11:39:14PM +0300, Sergei Shtylyov wrote:
> > From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > 
> > Add SATA clock for r8a7779 SoC (for both device tree and usual cases). 
> > Register SATA controller as a "late" platform device on r8a7779 SoC.
> 
> Hi,
> 
> If you have the a binding in the device tree (which you do through patch 1/3),
> then there's no reason to have a platform device for it.

Hi Olof,

the DT exists but currently the marzen board brings up all
of its devices using platform devices. Which if nothing else is
internally consistent.

I suppose it would be possible to add a call to
r8a7779_add_standard_devices_dt() and have the board bring
up this device using DT and the rest using platform drivers
(until the drivers are migrated to DT).

Would that be your preferred option?

Magnus, how do you feel about this idea?

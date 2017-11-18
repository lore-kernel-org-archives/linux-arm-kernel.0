From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 18 Nov 2017 10:27:04 -0800
Subject: [PATCH 5/10 v2] Input: cpcap-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <20171118082122.GB31757@n2100.armlinux.org.uk>
References: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
 <20171118082122.GB31757@n2100.armlinux.org.uk>
Message-ID: <20171118182704.2jtdu562iokx6zo2@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 08:21:22AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 18, 2017 at 02:36:53AM +0530, Arvind Yadav wrote:
> > platform_get_irq() can fail here and we must check its return value.
> 
> The test should be <= 0, and you need to return an error code for the
> 0 case.

Instead of polluting the drivers with special handling of 0 vs negative
error we should have platform_get_irq[_byname] return -EINVAL if it sees
0.

Thanks.

-- 
Dmitry

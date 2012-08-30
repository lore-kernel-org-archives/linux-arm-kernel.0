From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 30 Aug 2012 14:07:37 +0530
Subject: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <20120830000849.GD25765@n2100.arm.linux.org.uk>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <20120830000849.GD25765@n2100.arm.linux.org.uk>
Message-ID: <503F2651.50609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 August 2012 05:38 AM, Russell King - ARM Linux wrote:
> On Wed, Aug 29, 2012 at 02:26:15PM +0530, Rajendra Nayak wrote:
>> Moving to Common clk framework for OMAP would mean we no longer use
>> internal lookup mechanism like omap_clk_get_by_name().
>> get rid of all its usage mostly from hwmod and omap_device
>> code.
>>
>> Also use IS_ERR_OR_NULL() for error checking.
>
> This is wrong.  IS_ERR() is the only check you should ever use with clk_get().

okay, thanks, will fix.

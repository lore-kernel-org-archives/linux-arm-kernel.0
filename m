From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 3 Jan 2013 11:41:08 +0530
Subject: [PATCH v2 05/11] ARM: dt: tegra30: Add device node for APB MISC
In-Reply-To: <50E4AE19.1060503@wwwdotorg.org>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
 <1356619644-18565-6-git-send-email-pgaikwad@nvidia.com>
 <50E4AE19.1060503@wwwdotorg.org>
Message-ID: <50E520FC.4070805@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013 03:30 AM, Stephen Warren wrote:
> On 12/27/2012 07:47 AM, Prashant Gaikwad wrote:
>> APB misc contains multiple registers required by different modules
>> such as CAR.
> I don't see a DT binding document that describes what
> nvidia,tegra30-apbmisc means. Also, the register range for this new node
> overlaps that for the pinmux node, so they can't both "request" their
> register region. You may need multiple entries in the apbmisc reg
> property to avoid this.

apbmisc reg for Tegra30 can be divided into following entries:

strap registers
jtag configuration registers
pull_up/pull_down control registers
vclk control registers
tvdac registers
chip id revision registers
pad control registers

This list is not same for Tegra20 and Tegra30.

OR

another way is to add chip id revision register region to CAR node as 
done for pinmux node and remove apb misc node.

What is preferred?

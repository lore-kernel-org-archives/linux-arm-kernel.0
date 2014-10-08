From: alvin.chen@intel.com (Chen, Alvin)
Date: Wed, 8 Oct 2014 07:48:24 +0000
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <54348D56.20708@nexus-software.ie>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <54348D56.20708@nexus-software.ie>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E997E59@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> On 29/09/14 15:22, Weike Chen wrote:
> > +		.num_chipselect = 4,
> 
> How is this right ?
> 
> There's only one physical chip-select line per SPI master...
> 
> It's a 1:1 mapping.
> 
Now, we have another board which can support 4 slave spi per master, but not only Galileo. Since that board is not public, after discussing with team, we decide to make the
upstream code to support '1'.

I will change it back to 
.num_chipselect = 1,


> Best,
> Bryan

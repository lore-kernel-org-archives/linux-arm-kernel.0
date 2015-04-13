From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 13 Apr 2015 10:16:00 +0100
Subject: [Query] Direction of adding arm64 support to PCIe designware
 driver
In-Reply-To: <20150403174621.02681f0d@xhacker>
References: <20150403174621.02681f0d@xhacker>
Message-ID: <20150413091559.GA13091@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 10:46:21AM +0100, Jisheng Zhang wrote:
> Hi all,
> 
> Currently, the pci designware driver still lacks of arm64 support and I noticed
> that many works are done to achieve this goal.
> 
> Some patches are merged and some are under discussion. And Per my understanding, 
> even w/ these patches merged, the driver still doesn't support arm64. Could you
> please kindly point out the direction to add arm64 support to the PCIe
> designware driver?
> 
> Thanks in advance,
> Jisheng
> 

Hi Jisheng,

Sorry for my delay in answering, I was on holiday.

AFAIK there is no ready made version of the designware driver that will work for
arm64. Depending on your actual IP implementation, if is is SBSA compliant then
it should work with the generic host bridge driver rather than using the current
designware driver. If that doesn't fit your requirements then you will have to
update the existing driver to use the generic pci framework that arm64 needs.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?

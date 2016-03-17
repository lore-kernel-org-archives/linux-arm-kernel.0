From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Thu, 17 Mar 2016 13:14:12 -0300
Subject: NVMEM usage question
In-Reply-To: <1457956899.20370.25.camel@mtksdaap41>
References: <1457956899.20370.25.camel@mtksdaap41>
Message-ID: <20160317161412.GA24806@khazad-dum.debian.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Mar 2016, Eddie Huang wrote:
> 
> Mediatek PMIC chip have some spare registers used to store information.
> The value of these registers will exist until user unplug battery or
> battery depletion. One of our usage example is store battery utilization

i.e. like battery-backed raid caches.

> in these spare registers. We want to implement NVMEM driver to
> read/write sparse registers, but binding document describe NVMEM is for
> "Non-volatile memory", and for hardware like eeprom, efuse. Since the

Users will expect nvmem to not go away on battery drain, so I don't think it
would be the best fit, semantically speaking.

Unless this is common enough that it would make sense to have a generic
quasi-non-volatile profile for nvmem, and publish that constraint to
userspace in a standard way...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

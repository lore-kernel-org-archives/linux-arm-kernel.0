From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 20 Dec 2011 13:47:29 -0800
Subject: [PATCH V2 1/4] i2c: tegra: Add __devinit/exit to probe/remove
In-Reply-To: <CAM=Q2cs8K4vraWPNqervcmxEqUGiAbng+44+L9OhD3ijPw9tAA@mail.gmail.com>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
 <20111220015634.GA27789@quad.lixom.net>
 <CAM=Q2cs8K4vraWPNqervcmxEqUGiAbng+44+L9OhD3ijPw9tAA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92E21@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti Datta wrote at Monday, December 19, 2011 11:15 PM:
...
> Hi Stephen ,
> could you check this one also
> thanks.
> 
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> Date: Tue, 20 Dec 2011 11:40:51 +0530
> Subject: [PATCH] I2C : tegra : devexit in remove
> 
> Adding I2C __devexxit in remove
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

Ben or Olof,

> -       .remove  = tegra_i2c_remove,
> +       .remove  =__devexit_p(tegra_i2c_remove),

When you apply this, can you fix it up to add a space after the = in
the modified line? If you want, I can post an updated version to do that.

-- 
nvpublic

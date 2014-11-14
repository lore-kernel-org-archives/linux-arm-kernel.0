From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 14 Nov 2014 12:33:01 +0000
Subject: [PATCH] DMA: Fix allocation size for PL330 data buffer depth.
In-Reply-To: <20141112093952.GD24582@intel.com>
References: <1415294412-13818-1-git-send-email-Liviu.Dudau@arm.com>
 <20141112093952.GD24582@intel.com>
Message-ID: <20141114123301.GK12037@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 09:39:52AM +0000, Vinod Koul wrote:
> On Thu, Nov 06, 2014 at 05:20:12PM +0000, Liviu Dudau wrote:
> > The datasheet for PL330 says that the data buffer value in the CRD
> > register is 10bits wide. However, the value stored is "minus one",
> > which the driver corrects for. Maximum value that the data buffer
> > depth can have is 1024 lines, which requires 11 bits for storage.
> > 
> > While making updates I found printing the peripheral ID as a hex
> > value to be more useful as the datasheet shows the values that way.
> 
> Applied, thanks

Thanks!

> 
> Please snure you use the right subsytem name

Sorry about that. Just for clarity, it should've been 'dmaengine', right?

Best regards,
Liviu

> 
> -- 
> ~Vinod
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?

From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Wed, 4 Jan 2012 14:27:38 +0000
Subject: [PATCH v8 1/2] davinci: vpif: remove machine specific header
 file inclusion from the driver
In-Reply-To: <4F044D21.1030204@mvista.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
 <1325661469-4411-2-git-send-email-manjunath.hadli@ti.com>
 <4F044D21.1030204@mvista.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F75019F95@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,
On Wed, Jan 04, 2012 at 18:29:13, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-01-2012 11:17, Manjunath Hadli wrote:
> 
> > remove unnecessary inclusion of machine specific header files 
> > mach/dm646x.h, mach/hardware.h from vpif.h  and aslo mach/dm646x.h 
> > from vpif_display.c driver which comes in the way of platform code consolidation.
> > Add linux/i2c.h header file in vpif_types.h which is required for 
> > building.
> 
>     This last modification should be in a separate patch. Don;t mix changes having the different purpose.
It is part of the same modification of removing the machine specific header.
When the header file was removed, it needed the i2c to be included due to 
a dependency and hence the inclusion.

Thx,
-Manju
> 
> > Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
> > Cc: Mauro Carvalho Chehab<mchehab@infradead.org>
> > Cc: LMML<linux-media@vger.kernel.org>
> 
> WBR, Sergei
> 

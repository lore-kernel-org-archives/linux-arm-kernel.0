From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2017 09:53:24 +0000
Subject: [PATCH v2] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <18eae1fb-4a3c-c230-4491-8d376468975c@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <840027acb4750542003dff17b4a8902ba8972754.1485368348.git.robin.murphy@arm.com>
 <20170126125249.GG14167@arm.com>
 <18eae1fb-4a3c-c230-4491-8d376468975c@arm.com>
Message-ID: <20170127095324.GB21144@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 03:20:47PM +0000, Robin Murphy wrote:
> On 26/01/17 12:52, Will Deacon wrote:
> > 3. We bite the bullet and implement some non-swiotlb DMA ops for the case
> >    when SWIOTLB is not used.
> 
> I'd already started thinking along those lines in the process of writing
> this patch - I'm happy to take that on, although it might be a wee bit
> tight for 4.11 now.

Ok, so I've merged this patch as-is for 4.11 because it is an improvement
over what we had before. Let's look at using separate ops in the long run.

Will

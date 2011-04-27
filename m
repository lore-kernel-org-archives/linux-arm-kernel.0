From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 27 Apr 2011 18:41:19 +0300
Subject: Clarification regarding DMA in s3c2440.
In-Reply-To: <201104262146.20149.mindentropy@gmail.com>
References: <201104262146.20149.mindentropy@gmail.com>
Message-ID: <201104271841.19619.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2011 19:16:19 mindentropy wrote:
> Hi All,
> 
>    I am having some trouble understanding the datasheet of s3c2440 CPU in
> the DMA part.(I am trying to understand the dma controller code).
> 
> In chapter 8 second page under the heading DMA request sources the
> number of sources should be 7 and not 4.

True

> In the s3c2410 the sources
> are 5 but they have given it as 4.

s3c2440 has 18 dma sources, but not every channel is valid for some source, 
check arch/arm/mach-s3c2440/dma.c, struct s3c24xx_dma_map - it follows table 
8-1 in mentioned datasheet.

Regards
Vasily

From: jakob@viketoft.se (Jakob Viketoft)
Date: Wed, 21 Apr 2010 14:47:16 +0200
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <p2y56d259a01004210411ie5f4b723n6cfd25e96333813@mail.gmail.com>
References: <4BCD96F0.5010506@viketoft.se>	
	<q2sf17812d71004200614n58fb6cabgd0686d3ab6788b23@mail.gmail.com>	
	<4BCDC645.5090001@viketoft.se>	
	<201004211144.41781.marek.vasut@gmail.com>	
	<j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>
	<p2y56d259a01004210411ie5f4b723n6cfd25e96333813@mail.gmail.com>
Message-ID: <4BCEF3D4.2030704@viketoft.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Guy wrote:
> On 4/21/10, Eric Miao <eric.y.miao@gmail.com> wrote:
> 
>>  I thought we were talking about SPI?
> 
> We are. It affects boards that have a single SD/MMC card on the SPI
> bus and use SFRMOUT as the chip select line, which impacts how the SPI
> driver needs to handle multi-part messages without dropping CS between
> transfers

Does this mean that this is a know issue with the pxa2xx spi driver? At 
the moment I'm rather pressed for time and have instead opted for 
compressing the two transfers (read command and actual read) into one. 
There is a slight memory overhead in writing, but nothing that will 
impact our system...

	/Jakob

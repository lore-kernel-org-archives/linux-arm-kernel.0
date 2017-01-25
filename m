From: mzoran@crowfest.net (Michael Zoran)
Date: Wed, 25 Jan 2017 04:37:06 -0800
Subject: [PATCH] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <9e74b2f91b0b4b649a898db47225e5ea3b6a0417.1485345401.git.robin.murphy@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <9e74b2f91b0b4b649a898db47225e5ea3b6a0417.1485345401.git.robin.murphy@arm.com>
Message-ID: <1485347826.2306.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-25 at 12:03 +0000, Robin Murphy wrote:
> hen bypassing SWIOTLB on small-memory systems, we need to avoid
> calling
> into swiotlb_dma_mapping_error() in exactly the same way as we avoid
> swiotlb_dma_supported(), because the former also relies on SWIOTLB
> state
> being initialised.
> 

I didn't submit the initial ARM64 port of the RPI 3, so I don't know
much about this.  But from a third personal point of view, this seems
to side step the main issue here.

>From an ARM64 subsystem point of view, what exactly is the
correct/recommended method for ensuring the mm subsystem is initialized
correctly?

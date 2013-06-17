From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 19:56:18 +0100
Subject: [RFC PATCH 08/11] dmaengine: PL08x: Add cyclic transfer support
In-Reply-To: <1371416058-22047-9-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-9-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130617185618.GP2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54:15PM +0200, Tomasz Figa wrote:
> @@ -561,9 +564,9 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
>  			bytes += get_bytes_in_cctl(llis_va[index].cctl);
>  
>  		/*
> -		 * A LLI pointer of 0 terminates the LLI list
> ++		 * A LLI pointer going backward terminates the LLI list

Spot the unfixed up merge error...

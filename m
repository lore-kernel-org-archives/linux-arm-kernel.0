From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2018 12:04:56 +0000
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <20181128150225.8D30.4A936039@socionext.com>
References: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
 <20181128150225.8D30.4A936039@socionext.com>
Message-ID: <20181128120455.GB24868@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

On Wed, Nov 28, 2018 at 03:02:25PM +0900, Kunihiko Hayashi wrote:
> I found that arm64 board that had AVE controller couldn't receive
> any packets after this change.
> 
> AVE controller (hardware) forces to ignore lower 2bits of buffer start address,
> that is, the address is always aligned with 4bytes.
> And more, the controller puts received datas with "2byte headroom" [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/socionext/sni_ave.c#n591

Is this "2-byte headroom" a fixed property of the hardware? If so, it seems
like you should just be using 2 instead of NET_IP_ALIGN when calculating the
DMA address of the skb buffer.

Will

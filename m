From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 22 Mar 2018 10:51:50 +0530
Subject: [PATCH v1 1/1] dmaengine: stm32-dmamux: fix a potential buffer
 overflow
In-Reply-To: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180322052150.GB15443@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 05:55:35PM +0100, Pierre-Yves MORDRET wrote:
> The bitfield dma_inuse is allocated of size dma_requests bits, thus a
> valid bit address is from 0 to (dma_requests - 1).
> When find_first_zero_bit() fails, it returns dma_requests as invalid
> address.
> Using such address for the following set_bit() is incorrect and, if
> dma_requests is a multiple of BITS_PER_LONG, it will cause a buffer
> overflow.
> Currently this driver is only used in DT stm32h743.dtsi where a safe value
> dma_requests=16 is not triggering the buffer overflow.
> 
> Fixed by checking the return value of find_first_zero_bit() _before_
> using it.

Applied, thanks

-- 
~Vinod

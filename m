From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 4 Mar 2011 15:27:26 +0530
Subject: [PATCH V2 11/13] dw_dmac: Allow src/dst msize & flow controller
	to be configured at runtime
In-Reply-To: <426996869f6231ebff1cbfab5c7ee4c89ccc8745.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
	<426996869f6231ebff1cbfab5c7ee4c89ccc8745.1299146382.git.viresh.kumar@st.com>
Message-ID: <4D70B786.3010509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2011 03:47 PM, Viresh KUMAR wrote:
> From: Viresh KUMAR <viresh.kumar@st.com>
> 
> Msize or Burst Size is peripheral dependent in case of slave_sg transfers, and
> in case of memcpy transfers it is platform dependent. So msize configuration
> must come from platform data.
> 
> Also some peripherals (ex: JPEG), need to be flow controller for dma transfers,
> so this information in case of slave_sg transfers must come from platform data.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c      |   10 ++++++----
>  drivers/dma/dw_dmac_regs.h |    1 +
>  include/linux/dw_dmac.h    |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 4 deletions(-)
> 

Sorry, i missed similar changes for dw_dma_cyclic_prep(). Will resend it.

--
viresh

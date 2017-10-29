From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Sun, 29 Oct 2017 18:57:37 +0100
Subject: [PATCH v2 2/3] mtd: spi-nor: stm32-quadspi: fix prefetching
 outside fsize
In-Reply-To: <1509030755-19044-3-git-send-email-ludovic.Barre@st.com>
References: <1509030755-19044-1-git-send-email-ludovic.Barre@st.com>
 <1509030755-19044-3-git-send-email-ludovic.Barre@st.com>
Message-ID: <d438795f-b5a5-b275-2058-ef48bc68fc2d@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/10/2017 ? 17:12, Ludovic Barre a ?crit?:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> When memory-mapped mode is used, a prefetching mechanism fully
> managed by the hardware allows to optimize the read from external
> the QSPI memory. A 32-bytes FIFO is used for prefetching.
> When the limit of flash size - fifo size is reached the prefetching
> mechanism tries to read outside the fsize.
> The stm32 quadspi hardware become busy and should be aborted.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Reported-by: Bruno Herrera <bruherrera@gmail.com>
> Tested-by: Bruno Herrera <bruherrera@gmail.com>

Applied to the spi-nor/next branch of l2-mtd

Thanks!

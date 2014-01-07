From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jan 2014 16:11:36 +0000
Subject: [PATCH v3 09/36] mtd: st_spi_fsm: Provide device look-up table
In-Reply-To: <52B016A0.3080201@st.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-10-git-send-email-lee.jones@linaro.org>
 <20131210220338.GF27149@ld-irv-0074.broadcom.com>
 <52B016A0.3080201@st.com>
Message-ID: <20140107161136.GK3182@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +/* SPI Flash Device Table */
> >> +struct flash_info {
> >> +	char		*name;
> >> +	/*
> >> +	 * JEDEC id zero means "no ID" (most older chips); otherwise it has
> >> +	 * a high byte of zero plus three data bytes: the manufacturer id,
> >> +	 * then a two byte device id.
> >> +	 */
> >> +	u32		jedec_id;
> >> +	u16             ext_id;
> > 
> > Will 5 bytes of ID be enough? I think we're running into a need for 6
> > bytes of ID in m25p80.c right about now. Might make sense to start with
> > the right number of bytes.
> 
> Yes, we will need 6 bytes of ID.  The "dirty" stm_spi_fsm driver already handles
> arbitrary-length IDs.  This will need to be pulled into the "upstream" version
> at some point.

Just looking at this now. May I do this subsequently? It's a pretty
big change and I don't want to disturb the patch-set too much at this
moment. The "dirty" kernel has only been updated with this change
recently. We will need it too, but we can definitely do without it for
a little while.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 15:32:27 +0200
Subject: [PATCH 43/74] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <4C8627EE.6090606@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
	<20100906224050.GA8153@game.jcrosoft.org> <4C86192C.801@st.com>
	<20100907113850.GE30509@game.jcrosoft.org>
	<4C8627EE.6090606@st.com>
Message-ID: <20100907133227.GG30509@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:24 Tue 07 Sep     , viresh kumar wrote:
> On 9/7/2010 5:08 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>> +/* emi nor flash device registeration */
> >>>>> > >> > +static struct physmap_flash_data emi_norflash_data;
> >>>>> > >> > +
> >>>>> > >> > +static struct resource emi_nor_resources[] = {
> >>>>> > >> > +     {
> >>>>> > >> > +             .start  = SPEAR310_EMI_MEM_0_BASE,
> >>>>> > >> > +             .end    = SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
> >>>>> > >> > +             .flags  = IORESOURCE_MEM,
> >>>>> > >> > +     },
> >>>>> > >> > +};
> >>> > > it's board specfic not mach
> >>> > > 
> >>> > > NACK
> >> > 
> >> > No. This is machine specific. Same for all boards.
> > NACK as you can have a flash at other place and more than one flash
> > and the size depend on the flash
> 
> Correct!! Size has to be board specific. Will modify it.
and the start also as you may have 2 nor flash on different bank

Best Regards,
J.

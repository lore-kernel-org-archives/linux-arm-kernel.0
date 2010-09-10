From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Sep 2010 11:21:13 +0200
Subject: [PATCH 43/74] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <4C89F512.3030502@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
	<20100906224050.GA8153@game.jcrosoft.org> <4C86192C.801@st.com>
	<20100907113850.GE30509@game.jcrosoft.org>
	<4C8627EE.6090606@st.com>
	<20100907133227.GG30509@game.jcrosoft.org>
	<4C89E82A.4000902@st.com> <20100910085613.GK9112@game.jcrosoft.org>
	<4C89F512.3030502@st.com>
Message-ID: <20100910092113.GL9112@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:36 Fri 10 Sep     , Vipin Kumar wrote:
> On 9/10/2010 2:26 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 13:41 Fri 10 Sep     , Vipin Kumar wrote:
> >> On 9/7/2010 7:02 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> On 17:24 Tue 07 Sep     , viresh kumar wrote:
> >>>> On 9/7/2010 5:08 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>>>>>> +/* emi nor flash device registeration */
> >>>>>>>>>>>>> +static struct physmap_flash_data emi_norflash_data;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +static struct resource emi_nor_resources[] = {
> >>>>>>>>>>>>> +     {
> >>>>>>>>>>>>> +             .start  = SPEAR310_EMI_MEM_0_BASE,
> >>>>>>>>>>>>> +             .end    = SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
> >>>>>>>>>>>>> +             .flags  = IORESOURCE_MEM,
> >>>>>>>>>>>>> +     },
> >>>>>>>>>>>>> +};
> >>>>>>>>> it's board specfic not mach
> >>>>>>>>>
> >>>>>>>>> NACK
> >>>>>>>
> >>>>>>> No. This is machine specific. Same for all boards.
> >>>>> NACK as you can have a flash at other place and more than one flash
> >>>>> and the size depend on the flash
> >>>>
> >>>> Correct!! Size has to be board specific. Will modify it.
> >>> and the start also as you may have 2 nor flash on different bank
> >>>
> >>
> >> The start addresses in our case are fixed for a particular bank.
> > but not for the nor so let this decide by every board
> > not by the SoC
> > 
> 
> The NOR memory is placed within the system memory address space.
> For NAND offourse, it lies beyond system space. 
> 
> EMI is a Parallel NOR memory controller and the base address and 
> maximum size of each bank is fixed in our system...
but the then is not necessarely at bank 0

Best Regards,
J.

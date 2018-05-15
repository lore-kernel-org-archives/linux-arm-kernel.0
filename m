From: JOLLYS@xilinx.com (Jolly Shah)
Date: Tue, 15 May 2018 20:29:15 +0000
Subject: [PATCH v6 04/11] firmware: xilinx: Add query data API
In-Reply-To: <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
 <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
 <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
 <ab9632f5-882d-462d-d830-0316cad56baf@arm.com>
Message-ID: <SN1PR02MB375832594C7B5684888B213BB8930@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Tuesday, May 15, 2018 2:34 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v6 04/11] firmware: xilinx: Add query data API
> 
> 
> 
> On 14/05/18 20:16, Jolly Shah wrote:
> > HI Sudeep,
> >
> 
> [...]
> 
> >>
> >> Can you give more insight into this ? How will be this used ? How
> >> this aligns with data we get from DT ? I am just trying to understand
> >> how is this information split between this API and DT for example.
> >>
> >
> > This API is used to get clock information from firmware and register
> > clocks accordingly in driver. In our case, firmware maintains database
> > of all clocks available on chip. DT will provide information for off
> > chip reference clocks only. This is to avoid duplication of clocks
> > data in DT and firmware both as firmware anyways need clock data to
> > manage them.
> >
> 
> I wanted to understand the difference with example. What kind of information
> you get from DT and what you get from firmware ?
> 
> --
> Regards,
> Sudeep


Below is an example showing PLL and Leaf clock derivation:

Input ref clocks->Mux->Multiplier/Divider->PLL*
Pll1/pll2/pll3/pll4->Mux->Divider->Gate->Leaf clock1

Here Off chip input ref clock information comes from DT.
Rest information for Pll/leaf clocks come from firmware using query API. For clock driver, query API is used to get topology, flags, parents etc information per clock.

Thanks,
Jolly Shah

From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 25 May 2018 19:23:49 +0000
Subject: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
In-Reply-To: <6579fdce-6845-70d5-1dc1-64d52debef19@arm.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
 <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
 <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
 <6579fdce-6845-70d5-1dc1-64d52debef19@arm.com>
Message-ID: <SN1PR02MB3758876A011FFF46C71C8F6CB8690@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Tuesday, May 15, 2018 1:58 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
> APIs
> 
> 
> 
> On 14/05/18 20:18, Jolly Shah wrote:
> > Hi Sudeep,
> 
> [..]
> 
> >>
> >> As I mentioned in earlier patch, I don't see the need for this
> >> debugfs interface. Clock lay has read-only interface in debugfs
> >> already. Also if you want to debug clocks, you can do so using the
> >> driver which uses these clocks. Do you really want to manage clocks
> >> in user-space ? The whole idea of EEMI kind of interface is to
> >> abstract and hide the fine details even from non-trusted rich OS like
> >> Linux kernel, but by providing this you are doing exactly opposite.
> >
> > No we don't want to manage clocks in user-space. This debugfs is meant
> > for developer who wants to debug APIs behavior in case something
> > doesn't work as expected. Debugfs should be off by default in
> > production images.
> >
> 
> Good that it's not used in production image. The clock layer has
> *sufficient* debugfs support that will *help in debugging*. So please drop this
> Xilinx specific clock debugfs.
> 
> --
> Regards,
> Sudeep

Ok. Will remove them in next version. Let me know if rest changes look ok and I can submit final version with suggested minor changes.

Thanks,
Jolly Shah

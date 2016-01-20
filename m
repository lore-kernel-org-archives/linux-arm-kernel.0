From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Wed, 20 Jan 2016 05:51:15 +0000
Subject: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc
 for Arasan SDHCI.
In-Reply-To: <20160119171611.GA2708@rob-hp-laptop>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
 <20160119171611.GA2708@rob-hp-laptop>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C527B7@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, January 19, 2016 10:46 PM
> To: Lakshmi Sai Krishna Potthuri
> Cc: Michal Simek; Soren Brinkmann; Ulf Hansson; Kevin Hao; Emil P. Lenchak;
> Tobias Klauser; Sudeep Holla; Adrian Hunter; Jisheng Zhang; Ivan T. Ivanov;
> Scott Branden; Vincent Yang; Haibo Chen; Marek Vasut;
> ludovic.desroches at atmel.com; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Suman Tripathi; Shawn Lin; devicetree at vger.kernel.org; Harini
> Katakam; linux-mmc at vger.kernel.org; linux-kernel at vger.kernel.org;
> Lakshmi Sai Krishna Potthuri; Anirudha Sarangi; Punnaiah Choudary Kalluri;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding
> doc for Arasan SDHCI.
>
> On Tue, Jan 19, 2016 at 07:47:34PM +0530, P L Sai Krishna wrote:
> > This patch adds broken-mmc-highspeed property to the binding doc for
> > Arasan SDHCI.
> >
> > Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
> > ---
<snip>
> > -
> > +  - broken-mmc-highspeed: Indicates to force
> > +                           the controller to use in standard speed.
>
> We already have the inverse of this with "cap-mmc-highspeed".
>
> The only potential problem is it will need to be added to existing DTs if you
> start disabling high speed by default. Maybe that's not an issue for users of
> the Arasan driver.
>

It might be an issue for other users.
I know that it will be an issue for older Xilinx SoC (Zynq), for ex.

> Otherwise, you should determine this with a more specific compatible string.
>

Since this feature might be broken on any SoC, I thought it would be
good to provide a dt property.
Using a compatibility string will offer no flexibility as per board or silicon.

Regards,
Harini


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 30 Jul 2018 10:13:26 +0000
Subject: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
In-Reply-To: <20180729125106.05692a44@archlinux>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
 <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
 <20180729125106.05692a44@archlinux>
Message-ID: <SN6PR02MB495915F6DDEC42F4F44DB13BC12F0@SN6PR02MB4959.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,


> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23 at kernel.org]
> Sent: Sunday, July 29, 2018 5:21 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: Sai Krishna Potthuri <lakshmis@xilinx.com>; Michal Simek
> <michals@xilinx.com>; pmeerw at pmeerw.net; lars at metafoo.de;
> knaack.h at gmx.de; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-iio at vger.kernel.org
> Subject: Re: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
> 
> On Mon, 23 Jul 2018 20:32:01 +0530
> Manish Narani <manish.narani@xilinx.com> wrote:
> 
> > This patch limits the xadc pcap clock frequency value to be less than
> > 200MHz. This fixes the issue when zynq is booted at higher frequency
> > values, pcap crosses the maximum limit of 200MHz(Fmax) as it is
> > derived from IOPLL.
> > If this limit is crossed it is required to alter the WEDGE and REDGE
> > bits of XADC_CFG register to make timings better in the interface. So
> > to avoid alteration of these bits every time, the pcap value should
> > not cross the Fmax limit.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> 
> Applied, to the togreg branch of iio.git.  If you want this backported to stable,
> then request it once this patch is upstream.  It may be sometime given we've
> probably just missed the coming merge window.
> 
> If you do need it faster then let me know and I'll look at moving it over to the
> branch of fixes during the RC phases.
Thanks for getting this applied. There is no concern for this to be in the stable
ASAP. I can wait.

Thanks & Regards,
Manish Narani

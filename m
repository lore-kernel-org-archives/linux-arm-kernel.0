From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Thu, 16 Jun 2016 07:54:28 -0300
Subject: [PATCH v3 0/9] Add MT8173 Video Decoder Driver
In-Reply-To: <1465902488.27938.7.camel@mtksdaap41>
References: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
 <20160607112235.475c2e4c@recife.lan> <575746EE.3030706@cisco.com>
 <1465902488.27938.7.camel@mtksdaap41>
Message-ID: <20160616075428.0fde4aaa@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, 14 Jun 2016 19:08:08 +0800
tiffany lin <tiffany.lin@mediatek.com> escreveu:

> Hi Mauro,
> 
> 
> On Wed, 2016-06-08 at 07:13 +0900, Hans Verkuil wrote:
> > 
> > On 06/07/2016 11:22 PM, Mauro Carvalho Chehab wrote:  
> > > Em Mon, 30 May 2016 20:29:14 +0800
> > > Tiffany Lin <tiffany.lin@mediatek.com> escreveu:
> > >  
> > >> ==============
> > >>   Introduction
> > >> ==============
> > >>
> > >> The purpose of this series is to add the driver for video codec hw embedded in the Mediatek's MT8173 SoCs.
> > >> Mediatek Video Codec is able to handle video decoding of in a range of formats.
> > >>
> > >> This patch series add Mediatek block format V4L2_PIX_FMT_MT21, the decoder driver will decoded bitstream to
> > >> V4L2_PIX_FMT_MT21 format.
> > >>
> > >> This patch series rely on MTK VPU driver in patch series "Add MT8173 Video Encoder Driver and VPU Driver"[1]
> > >> and patch "CHROMIUM: v4l: Add V4L2_PIX_FMT_VP9 definition"[2] for VP9 support.
> > >> Mediatek Video Decoder driver rely on VPU driver to load, communicate with VPU.
> > >>
> > >> Internally the driver uses videobuf2 framework and MTK IOMMU and MTK SMI both have been merged in v4.6-rc1.
> > >>
> > >> [1]https://patchwork.linuxtv.org/patch/33734/
> > >> [2]https://chromium-review.googlesource.com/#/c/245241/  
> > >
> > > Hmm... I'm not seeing the firmware for this driver at the
> > > linux-firmware tree:
> > > 	https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/log/
> > >
> > > Nor I'm seeing any pull request for them. Did you send it?
> > > I'll only merge the driver upstream after seeing such pull request.  
> >   
> Sorry, I am not familiar with how to upstream firmware.
> Do you mean we need to upstream vpu firmware first before merge encoder
> driver upstream?

Please look at this page:
	https://linuxtv.org/wiki/index.php/Development:_How_to_submit_patches#Firmware_submission

The information here can also be useful:
	https://www.kernel.org/doc/readme/firmware-README.AddingFirmware

In summary, you need to provide redistribution rights for the
firmware blob. You can either submit it to me or directly to
linux-firmware. In the latter, please c/c me on such patch.

Thanks!
Mauro

> 
> In
> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tree/README, it mentions that 
> "To submit firmware to this repository, please send either a git binary
> diff or preferably a git pull request to: linux-firmware at kernel.org and
> also cc: to related mailing lists."
> 
> How we made a git pull request to linux-firmware at kernel.org? 
> How we find out related mailing lists?
> 
> best regards,
> Tiffany
> 
> > Mauro, are you confusing the decoder and encoder driver? I haven't thoroughly reviewed the decoder driver
> > yet, so there is no pull request for the decoder driver.
> > 
> > The only pull request I made was for the encoder driver.
> > 
> > Regards,
> > 
> > 	Hans  
> 
> 


-- 
Thanks,
Mauro

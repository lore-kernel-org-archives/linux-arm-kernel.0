From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Tue, 04 Dec 2012 18:34:59 -0800
Subject: [RFC] dt/platform: Use cell-index for device naming if available
In-Reply-To: <20121120161957.7CE973E102F@localhost>
References: <1352508532-19241-1-git-send-email-stepanm@codeaurora.org>
 <509F0E56.6080806@gmail.com>
 <CACxGe6s3gJ4fmhn9VBd1Fq8bH5S0_ejmE=KqVjYn20bT42wQ_Q@mail.gmail.com>
 <554191d69bc21a4b133fb876df84ff89.squirrel@www.codeaurora.org>
 <50A1B50B.4020509@codeaurora.org> <20121115161020.3205E3E194B@localhost>
 <50A70485.90302@codeaurora.org> <20121120161957.7CE973E102F@localhost>
Message-ID: <50BEB2D3.7000101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 8:19 AM, Grant Likely wrote:
> What if instead we added something like OF_ALIASES to the uevent
> attribute? Then userspace would have access to all the aliases for a
> device. Heck, even a shell script can parse the uevent attribute. There
> is also precedence for exporting OF data using a uevent. This is from
> the versatile device tree support:
>
> # cat /sys/devices/amba.0/uevent
> OF_NAME=amba
> OF_FULLNAME=/amba
> OF_COMPATIBLE_0=arm,amba-bus
> OF_COMPATIBLE_N=1
> MODALIAS=of:NambaT<NULL>Carm,amba-bus

This sounds like a good idea. I have just sent out a new patch to do 
this. I followed the OF_COMPATIBLE uevent convention for listing the 
aliases, but I can follow another convention if someone objects.

Steve

-- 
  The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
  hosted by The Linux Foundation

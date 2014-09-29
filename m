From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 30 Sep 2014 01:21:38 +0200
Subject: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
In-Reply-To: <20140929205922.GB2758@katana>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <20140929205922.GB2758@katana>
Message-ID: <5429E982.4050509@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On 09/29/2014 10:59 PM, Wolfram Sang wrote:
> On Fri, Sep 19, 2014 at 10:08:12AM +0200, Sjoerd Simons wrote:
>> To enable the cros-ec-tunnel driver to be auto-loaded when build as a
>> module add an of match table (and export it) to match the modalias
>> information passed on to userspace as the Cros EC MFD driver registers
>> the MFD subdevices with an of_compatibility string.
>> 
>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Applied to for-next, thanks!
> 
> However, since you are working on this driver: sparse rightfully
> complains about:
> 
> drivers/i2c/busses/i2c-cros-ec-tunnel.c:97:44: warning: cast truncates bits from constant value (10000 becomes 0)
> 
> I don't know the EC protocol, can you check?
> 

Doug posted a patch [0] to fix the issue you are reporting but it was not
picked. I tested that the patch applies on top of linux-next + the latest
cros_ec cleanups (that includes a patch for this i2c driver and was taken
by Lee. So I think is safe for you take Doug's patch through your tree
since it seems to not cause any conflict with the mfd tree.

Or if you prefer, I can re-post that patch for 3.19.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/23/830

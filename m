From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 11 Dec 2014 10:12:20 +0530
Subject: [PATCH 2/3] dmaengine: at_xdmac: simplify channel configuration
 stuff
In-Reply-To: <20141209095030.GI27228@ldesroches-Latitude-E6320>
References: <1417018949-24246-1-git-send-email-ludovic.desroches@atmel.com>
 <1417018949-24246-3-git-send-email-ludovic.desroches@atmel.com>
 <20141208103918.GF16827@intel.com>
 <20141208140500.GF27228@ldesroches-Latitude-E6320>
 <20141209061308.GY16827@intel.com>
 <20141209095030.GI27228@ldesroches-Latitude-E6320>
Message-ID: <20141211044220.GG16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 10:50:30AM +0100, Ludovic Desroches wrote:
> > > > only thing here wer are saving and restoring from save_cc. How does that
> > > > impact rest of the code above?
> > this part is the only one which is clear. I think right way would be to
> > split these changes and explain in each one why we are doing them. Down
> > the line when someone is working on this will know precisely why this change
> > was made. Two years is a long time, even we will forget. So good changelog
> > and splitting patches to do just one thing is very helpful
> 
> I don't see why this patch should be split. The goal is to remove the
> configuration register snapshot and to put it in the lli descriptor.
> Because I am removing this snapshot, I have to update suspend/resume and
> the way I have chosen is to directly get the value from the hardware
> register. If it is a blocking point I'll split it. I think you want me
> to put the addition of the save_cc field into another patches but I have
> no reason to do it before patch 2 since I have not encountered any bug
> yet (even if I think it is safer). And if I don't do it in patch 2,
> suspend/resume will be broken.
cant the save cc bits come first and then rest of contents in this patch
> 
> 
> About the commit message I could elaborate a bit more:
> 
> This patch simplifies the channel configuration register management.
> Relying on a "software snapshot" of the configuration is not safe and
> too complex.
> 
> Multiple dwidths will be introduced for slave transfers. In this case,
> it becomes quite difficult to have an accurate snapshot of the channel
> configuration register in the way it is done. Using the channel
> configuration available in the lli descriptor simplifies this stuff.
much better :)

-- 
~Vinod

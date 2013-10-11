From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 Oct 2013 22:37:28 +0000 (UTC)
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <52584785.2020504@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
 <525654AE.7060009@ti.com>
 <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
 <52584785.2020504@ti.com>
Message-ID: <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> Oh yea, one additional note you probably have missed. Mike asked us to fall
> back to vendor specific bindings at around v6 or so of this set. Take a look
> at v8, we have dropped the use of generic bindings, we are not trying to
> declare those with this set.

No, I didn't miss it.

> This set introduces vendor specific bindings only, and even these are 
> claimed 'unstable', which should be enough to discourage people from 
> burning those to OTP type memory.

Better to just avoid merging unstable bindings in the first place.

Please keep this in mind: any change that anyone makes to the DT data 
needs to be supportable by the kernel into the indefinite future, once it 
makes it into arch/arm/boot/dts or the DT binding documentation.  Also, 
any changes need to work for other OSes, i.e., the changes should not be 
Linux-specific.

Those have been stated goals for the Linux DT project since day one.  
Some folks haven't been monitoring those goals very closely and that's 
unfortunate.  We could have avoided some pretty big messes.


- Paul

From: geoff@infradead.org (Geoff Levand)
Date: Wed, 03 Sep 2014 11:17:28 -0700
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <20140903175340.GN3127@leverpostej>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <1409764991.21254.139.camel@smoke> <20140903175340.GN3127@leverpostej>
Message-ID: <1409768248.21254.150.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2014-09-03 at 18:53 +0100, Mark Rutland wrote:
> > Be aware that if you have set it up this way, users will not be able to
> > use this file with kexec's --dtb=FILE to specify a 2nd stage DT file.
> > kexec will use a copy of the DT from the 1st stage in this case.
> 
> Surely the latter is the default and the former is the "trust me I know
> what I'm doing" case?
> 
> In general there are other things you might need to fill in anyhow (like
> dynamically populated memory), so I don't see that as a big isssue
> (though admittedly painful if you're testing things in that area).

Yes, the --dtb=FILE is for flexibility in testing and also could
help in the case where an old kernel + dt is installed as a kexec
based boot loader and a new DT is desired in booting a newer kernel.

One could always hand edit a DTS file to be acceptable to kexec-tools
though.

-Geoff

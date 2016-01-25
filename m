From: dyoung@redhat.com (Dave Young)
Date: Mon, 25 Jan 2016 11:19:17 +0800
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <56A1CAD2.70403@linaro.org>
References: <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org> <20160120114929.GB25829@leverpostej>
 <56A08076.8060302@linaro.org> <20160121120210.GD2581@leverpostej>
 <56A1CAD2.70403@linaro.org>
Message-ID: <20160125031917.GA5616@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, AKASHI

> >To place "elfcorehdr=" or "memmap="/"usable-memory=" into the command
> >line, one needs to know where it is valid to place it. Appending doesn't
> >always work, as per the example above with 51e158c12aca3c9a.
> 
> So, are you now suggesting that we put both "elfcorehdr=" and
> "usable-memory=" under /chosen in dtb? That's fair enough.
> (as far as nobody cares about incompatibility with other archs.)

You may need move is_kdump_kernel as a weak function so that in arm64 you
can still use it in kdump kernel.

Thanks
Dave

From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Tue, 12 Jun 2012 21:40:31 +0200
Subject: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
In-Reply-To: <CAOMZO5B7+Qy06m7O=v1M3vt7to7ciKOhQOihVgAEf+utntvw4w@mail.gmail.com>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter> <20120514042142.GD9750@kroah.com>
 <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi> <1338809424.3371.20.camel@mars>
 <1338809853.3371.31.camel@mars>
 <CAOMZO5B7+Qy06m7O=v1M3vt7to7ciKOhQOihVgAEf+utntvw4w@mail.gmail.com>
Message-ID: <1339530031.3454.16.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

On Sun, 2012-06-10 at 15:41 -0300, Fabio Estevam wrote:
> Hi Christoph,
> 
> On Mon, Jun 4, 2012 at 8:37 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > After that, I stumbled upon this dmesg:
> >
> > Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
> > fsl-usb2-udc fsl-usb2-udc: clk_get("usb") failed
> > fsl-usb2-udc: probe of fsl-usb2-udc failed with error -2
> >
> > Sascha, could you give me a hint?
> 
> Does the patch below fix your problem?

Thanks for your patch. It does indeed load
"Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)"
fine - but now when I want to use it:

modprobe g_ether
[   17.099363] g_ether gadget: using random self ethernet address
[   17.105316] g_ether gadget: using random host ethernet address
[   17.111974] usb0: MAC 1a:c7:9e:76:cc:45
[   17.115866] usb0: HOST MAC 66:a2:4a:0a:46:17
[   17.120199] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[   17.126861] g_ether gadget: g_ether ready

these are "the last words": System hangs completely. Same behavior with
g_serial (these two I've tested).

Currently I can't investigate this further, not because of a bug - but a
flu.


Thanks,
 -- Christoph

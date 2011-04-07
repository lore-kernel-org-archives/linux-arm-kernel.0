From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 7 Apr 2011 02:54:33 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <1302134429.27258.32.camel@dev.znau.edu.ua>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
	<BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
	<1302123428.20093.6.camel@maggie>
	<BANLkTimGSoYzp0Z4vyCS_H5PDKhgjYuLBA@mail.gmail.com>
	<1302124112.20093.11.camel@maggie>
	<BANLkTik76dwwnmmPzXL9Kkk7fdt01QPzZA@mail.gmail.com>
	<1302124737.27258.7.camel@dev.znau.edu.ua>
	<BANLkTi=4-LgrkjG96+Ar3SjMOsKh-dMuLg@mail.gmail.com>
	<1302134429.27258.32.camel@dev.znau.edu.ua>
Message-ID: <BANLkTinfM0QLFwcKZXfWQ_jNYfBJg_et-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 7 kwietnia 2011 02:00 u?ytkownik George Kashperko
<george@znau.edu.ua> napisa?:
> For PCI function description take a look at PCI specs or PCI
> configuration space description (e. g.
> http://en.wikipedia.org/wiki/PCI_configuration_space)
>
> Sorry for missleading short-ups, w11 - bcm80211 core, under two-head I
> mean ssb/axi with two functional cores on same interconnect (like w11
> +w11, not a lot of these exists I guess). Also there were some b43+b44
> on single PCI ssb host and those where implemented as ssb interconnect
> on multifunctional PCI host therefore providing separate access windows
> for each function.
>
> Might I mussunderstood something (its late night here at my place) when
> you where talking about using coreswitching involved for two drivers
> therefore I remembered about those functions. Seems now you were talking
> about chipcommon+b43 access sharing same window.
>
> As for core switching requirments for earlier SSB interconnects on PCI
> hosts where there were no direct chipcommon access, that one can be
> accomplished without spin_lock/mutex for b43 or b44 cores with proper
> bus design.
>
> AXI doesn't need spinlocks/mutexes as both chipcommon and pci bridge are
> available directly and b43 will be the only one requiring window access.

Ahh, so while talking about 4 windows, I guess you counted fixes
windows as well. That would be right, matching my knowledge.

When asking question about amount of cores we may want to use
simultaneously I didn't think about ChipCommon or PCIe. The real
problem would be to support for example two 802.11 cores and one
ethernet core at the same time. That gives us 3 cores while we have
only 2 sliding windows. But I would not care for that too much for
now.

For the rest (PCI function) I have to sleep before reading specs ;)

-- 
Rafa?

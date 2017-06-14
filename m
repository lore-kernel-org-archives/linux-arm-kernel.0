From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 13 Jun 2017 23:55:37 -0600
Subject: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
In-Reply-To: <20170614050049.GA11630@kroah.com>
References: <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com> <20170613043518.GA14621@kroah.com>
 <8462abee-0a7f-00fb-6111-1f78362ea3f7@deltatee.com>
 <20170613163508.GA31961@kroah.com>
 <f848a5fb-096c-a025-cc3b-314cc3899f9e@deltatee.com>
 <20170614050049.GA11630@kroah.com>
Message-ID: <541d1104-6139-c902-ec91-943ec1e8a881@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/06/17 11:00 PM, Greg Kroah-Hartman wrote:
> No, don't modify any drivers, do this in the core chardev code.

Ok, well then maybe I misunderstood what you originally asked for
because I don't see how you can change a fixed allocation to a dynamic
one without touching the driver code which needs to know the major that
was assigned in the end.

> At quick glance, looks good to me, care to clean it up and make it behind
> a config option?

Sure. However, is a config option really necessary here? As is, the
extended dynamic region will only be used if there are too many chardev
majors and it shouldn't have _any_ effect on users that have a small
number. So it seems like not selecting that option is just telling the
kernel to be broken for no obvious trade-off.

Logan

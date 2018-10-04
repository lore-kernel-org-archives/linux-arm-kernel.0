From: sowmini.varadhan@oracle.com (Sowmini Varadhan)
Date: Thu, 4 Oct 2018 10:35:08 -0400
Subject: [PATCH v2 00/29] at24: remove at24_platform_data
In-Reply-To: <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
 <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
 <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
Message-ID: <20181004143508.GG13299@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just catching up on this thread, so please excuse any unintentional
misquotes here.

> > > > David: I couldn't find a place in sparc code where any ethernet device
> > > > would be registered, so is there a chance that nobody is using it?
> > >
> > > SPARC uses a true Open Firmware implementation, so it would register
> > > drivers through the CONFIG_OF infrastructure.

correct

> The calls are not even that old, and clearly added intentionally for sparc,
> see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
> which added the first one.

Yes, correct again. Wouldn't PPC also end up doing the same thing?

See also commit c762dff24c06 (for ixgbe) - without this fix sparc systems
will come up with a bogus mac address and then you end up having to
manually fix this in ugly ways.

--Sowmini

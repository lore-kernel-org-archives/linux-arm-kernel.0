From: nm@ti.com (Nishanth Menon)
Date: Sat, 6 Oct 2018 11:34:32 -0500
Subject: [PATCH 4/4] firmware: ti_sci: Add helper apis to mange resources
In-Reply-To: <176f77cf-d295-0f37-ea9d-26f76f6d79c7@ti.com>
References: <20181005143006.18284-1-lokeshvutla@ti.com>
 <20181005143006.18284-5-lokeshvutla@ti.com>
 <20181005201453.g3p2jhpigcvijpce@kahuna>
 <176f77cf-d295-0f37-ea9d-26f76f6d79c7@ti.com>
Message-ID: <20181006163432.z5skpgfm7oqoiuaf@akan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:08-20181006, Lokesh Vutla wrote:
> 
> 
> On 10/6/2018 1:44 AM, Nishanth Menon wrote:
> > NAK. Where is the binding for this? What is this decoding? Please don't
> > decode binding without having an official binding.
> 
> This is a helper library for the clients to get resource range from DT
> and is not compulsory for clients to use this library to managing these
> resources. So in my understanding DT bindings should go into the client
> DT doc as posted here[1].  If you really insist I can add these details

Thanks.. Please get the binding approved before we discuss
implementation in driver.

> in ti,sci documentation but not sure if we are doing the same for all
> other helper apis.

the core TISCI device does'nt require any ranges property. these need to
be parsed and handled in corresponding tisci drivers? I don't see the
benefit in dealing with OF parsing in generic TISCI firmware driver.
yes, there might be a little similarities, but really we'd have to argue
strongly why it needs to belong to the firmware driver. So far it looks
like just a single irq-chip driver seems to need it, I cant see the
argument for it getting caught up in that path.

--
Regards,
Nishanth Menon

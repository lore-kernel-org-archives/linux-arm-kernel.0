From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 10 Nov 2017 09:41:15 +0100
Subject: [PATCH v5 17/26] KVM: arm/arm64: GICv4: Handle INVALL applied to
 a vPE
In-Reply-To: <e247390a-c9d5-4c3a-5812-88b83e87ce10@redhat.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-18-marc.zyngier@arm.com>
 <e247390a-c9d5-4c3a-5812-88b83e87ce10@redhat.com>
Message-ID: <20171110084115.GJ14144@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 10:23:25PM +0100, Auger Eric wrote:
> Hi Marc,
> 
> On 27/10/2017 16:28, Marc Zyngier wrote:
> > Since when updating the properties one LPI at a time, there is no
> Since we update the properties one LPI at a time, ... ?
> > need to perform an INV each time we read one. Instead, we rely
> > on the final VINVALL that gets sent to the ITS to do the work.
> The commit message is not crystal clear for me.
> 
> I understand in case of vgic_its_cmd_handle_invall you want to avoid
> doing an invalidation for each physical irq but rather do an
> its_invall_vpe at the end. So you add a new  @needs_inv arg to
> update_lpi_config to tell whether the invalidation should be done or not.

I've reworded it to:

  There is no need to perform an INV for each interrupt when updating
  multiple interrupts.  Instead, we can rely on the final VINVALL that
  gets sent to the ITS to do the work for all of them.


Shout quickly if you have any objections.

Thanks,
-Christoffer

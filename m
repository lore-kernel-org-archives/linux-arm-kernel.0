From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Feb 2014 14:50:39 -0600
Subject: [PATCH v12 1/4] PHY: Add function set_speed to generic PHY
 framework
In-Reply-To: <CAPw-ZT=F07=T0=z=iT=hxJ0+609RBDYRL=MXF5dQoEowLjsRjQ@mail.gmail.com>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <20140227190102.GB4862@saruman.home>
 <CAPw-ZT=F07=T0=z=iT=hxJ0+609RBDYRL=MXF5dQoEowLjsRjQ@mail.gmail.com>
Message-ID: <20140227205039.GE5375@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 11:57:44AM -0800, Loc Ho wrote:
> > On Thu, Feb 27, 2014 at 11:14:05AM -0700, Loc Ho wrote:
> >> This patch adds function set_speed to the generic PHY framework operation
> >> structure. This function can be called to instruct the PHY underlying layer
> >> at specified lane to configure for specified speed in hertz.
> >
> > why ? looks like clk_set_rate() is your friend here. Can you be more
> > descriptive of the use case ? When will this be used ?
> >
> 
> The phy_set_speed is used to configure the operation speed of the PHY
> at run-time. The clock interface in general is used to configure the
> clock input to the IP. I don't believe they are the same thing. Maybe
> it will be clear in my response to your second email

The problem with this is that you end up adding SATA-specific details to
something which is supposed to be generic. After negoatiation, don't you
get any interrupt from your PHY indicating that link speed negotiation
is done ? Or is that IRQ only on AHCI IP ?


cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/ce88d27e/attachment.sig>

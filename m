From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 11 Mar 2015 20:36:54 +0100
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150311174316.GD5264@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com>
 <F7BA143D-5CF9-42E3-AFA8-B83B149EF77E@goldelico.com>
 <20150311174316.GD5264@atomide.com>
Message-ID: <20150311193654.GA3126@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 11, 2015 at 10:43:17AM -0700, Tony Lindgren wrote:
> No no, "capacity-uah" is what we should use, but you need an ack from
> the battery and device tree people that this is OK. Let's not add
> "ti,capacity-uah? as that can obviously be a generic property.

I'm okay with capacity-uah.

> > [...]
> 
> Oh if they are battery spicific, then ideally we'd have generic batery
> voltage to capacity maps property rather than a custom ti specific
> property.
> 
> To avoid extra hassles later on, maybe you could submit a generic
> binding patch only documenting it to the battery people and the device
> tree people? That will make it easier to maintain this driver in the
> long run.

Actually the proper way would be to differentiate between the
battery and the measurement chip / adc and that should be
implemented in the long run. The kernel's power supply framework
is not yet ready for it, though.

Example DT:

battery {
    battery-specific-data;
};

fuel-gauge {
    measures = <&battery>;
};

charger {
    charges = <&battery>;
};

Since infrastructure for generic bindings is missing, I think its
best to have the vendor properties for now and map this to generic
properties, once they have been specified.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/ba72c6cc/attachment.sig>

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 19:14:13 +0000
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <20130327181206.GD20990@mudshark.cambridge.arm.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <201303271750.52015.arnd@arndb.de>
 <20130327181206.GD20990@mudshark.cambridge.arm.com>
Message-ID: <201303271914.13544.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Will Deacon wrote:
> The interface is standard. The functions have well-defined headers and can
> be called in the same way between implementations. The difference is in the
> semantics of the parameters. For example:
> 
>   int cpu_off(u32 power_state);

I think that is the opposite of well-defined :(

> If you look at the power_state parameter, it's actually a struct (see struct
> psci_power_state) with a u16 id field. The current specification describes
> that field as `This is platform specific, the number is understood by the
> firmware, and used to program the power controller.'.
> 
> So unless we get everybody to agree on the definition of that field, we
> can't blindly plug the interfaces together. Furthermore, there are other
> parameters like this and, as new functions are specified, I would expect
> them to grow.

I think it's expected that there will be vendor specific extensions,
but any interface that is part of the standard has to be completely
specified there, anything else is pure madness.

Perhaps we could extend the device tree binding to add the missing bits,
and pass the values that you are supposed to pass there as properties
of the node, but it would be much more logical to require the interface
to be well-behaved in the first place.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 17:50:51 +0000
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <20130327170555.GA20990@mudshark.cambridge.arm.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <51531F76.2090200@gmail.com>
 <20130327170555.GA20990@mudshark.cambridge.arm.com>
Message-ID: <201303271750.52015.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Will Deacon wrote:
> The channel is common, sure, but I wouldn't expect the semantics of each
> call to be identical between firmware implementations (going back to my
> previous examples of CPU IDs and implementation-defined state parameters).
> 
> If a platform happens to have an id-mapping from smp_operations to psci,
> then I still think there should be an indirection in there so that we have
> the flexibility to change the smp_operations if we wish and not give
> platforms the false impression that these two things are equivalent.

I think the only reasonably implementation for psci is if we can assume
that each callback with a specific property name has a well-defined behavior,
and we should mandate that every platform that implements the callbacks
we need for SMP actually implements them according to the spec.

What would be the point of a standard psci interface if the specific
implementation are not required to follow the same semantics?

	Arnd

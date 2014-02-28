From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 28 Feb 2014 11:07:31 -0600
Subject: [PATCH 3/5] documentation/iommu: update description of ARM System
 MMU binding
In-Reply-To: <20140228162114.GA30996@mudshark.cambridge.arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
 <1393002992-24561-4-git-send-email-will.deacon@arm.com>
 <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
 <20140228162114.GA30996@mudshark.cambridge.arm.com>
Message-ID: <5310C253.40804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2014 10:21 AM, Will Deacon wrote:
>>> > >+- calxeda,smmu-secure-config-access : Enable proper handling of buggy
>>> > >+                  implementations that always use secure access to
>>> > >+                  SMMU configuration registers. In this case non-secure
>>> > >+                 aliases of secure registers have to be used during
>>> > >+                 SMMU configuration.
>> >
>> >I'm confused.  Why does this property have a "calxeda" prefix?  How is
>> >it a Calxeda-specific property?

> Because they wired up their SMMU backwards. It's basically an
> implementation-specific erratum workaround.

Hmmmm....

Other than making the same wiring mistake, is there any reason any other 
ARM chip would need this property set?

The reason I ask is that it's kinda weird (well, to me at least) that we 
have an property named for a specific SoC, but the implementation and 
documentation tries so hard to hide that fact.  I would think that the 
binding document would provide some explanation as to why the property 
has a "calxeda" prefix.

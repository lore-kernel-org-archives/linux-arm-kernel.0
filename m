From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 18 Apr 2017 14:46:50 +0100
Subject: [PATCH] arm64: xen: Implement EFI reset_system callback
In-Reply-To: <20170406155453.GA3966@leverpostej>
References: <20170405181417.15985-1-julien.grall@arm.com>
 <e5b548be-2ec3-9b4f-a456-929d5fb881ab@oracle.com>
 <b8c9c6cd-906a-2360-ca9f-d34a45258567@suse.com>
 <3f6f5853-cd08-8afc-f71a-b0c1545c7564@arm.com>
 <20170406142710.GE4372@olila.local.net-space.pl>
 <ed7f64f4-17db-e2a5-f362-b382666cbc36@suse.com>
 <20170406152040.GH4372@olila.local.net-space.pl>
 <e449f220-8db7-d58c-bdbf-47ccd6dd014b@arm.com>
 <20170406155453.GA3966@leverpostej>
Message-ID: <20170418134650.GL24360@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 06 Apr, at 04:55:11PM, Mark Rutland wrote:
> 
> Please, let's keep the Xen knowledge constrained to the Xen EFI wrapper,
> rather than spreading it further.
> 
> IMO, given reset_system is a *mandatory* function, the Xen wrapper
> should provide an implementation.
> 
> I don't see why you can't implement a wrapper that calls the usual Xen
> poweroff/reset functions.

I realise I'm making a sweeping generalisation, but adding
EFI_PARAVIRT is almost always the wrong thing to do.

I'd much prefer to see Mark's idea implemented.

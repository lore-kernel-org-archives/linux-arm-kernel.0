From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 27 Nov 2018 11:05:40 -0800
Subject: Sleeping in user_access section
In-Reply-To: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
 <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
Message-ID: <691acc7f-6ce1-69da-d56d-4d3c0fdad9ab@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/18 3:57 AM, Julien Thierry wrote:
> 
> On x86, the EFLAGS.AC bit is also saved upon exception and I think it is
> cleared upon exception entry so there is implicit exit from the
> user_access mode when taking exception/interrupt.
> 

No, it is restored, not cleared.

In summary: on exceptions, user_access regions are suspended, and on
return the user_access status is resumed.

However, explicitly calling sleeping functions is not supported.

	-hpa

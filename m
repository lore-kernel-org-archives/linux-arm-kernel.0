From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 10:15:06 -0700
Subject: [PATCH v3 29/32] arm64: KVM: 32bit guest fault injection
In-Reply-To: <5177E244.9000404@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-30-git-send-email-marc.zyngier@arm.com>
 <20130423230214.GM20569@gmail.com> <5177E244.9000404@arm.com>
Message-ID: <CAEDV+g+J4NOcfAXB8QzXqo87mMTenK7kyXRPth_gHZBfOv80Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 6:46 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 24/04/13 00:02, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:31PM +0100, Marc Zyngier wrote:
>>> Add fault injection capability for 32bit guests.
>>
>> looks ok, but seems we are duplicating some functionality here, but I
>> realize it may not be that easy to share due to different define names
>> for things like PSR_X_BIT...  Did you look further into this?
>
> I did, but as you noticed, the namespaces are different. We could
> probably define a set of KVM_AARCH32_* symbols, but I'm not sure it
> would be any nicer though.
>
yeah, it's not code that's very likely to change and evolve over time,
so I guess we can live with the duplication...

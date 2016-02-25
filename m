From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 25 Feb 2016 14:48:16 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <20160225113610.351149bf@free-electrons.com>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
 <20160224184114.GB2292@1wt.eu>
 <20160224223350.GP19428@n2100.arm.linux.org.uk>
 <20160225113610.351149bf@free-electrons.com>
Message-ID: <op.ydd5yqmx2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2016 11:36:10 +0100, Thomas Petazzoni  
<thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed, 24 Feb 2016 22:33:50 +0000, Russell King - ARM Linux wrote:
>
>> I didn't say no to it, I merely asked a few pertinent questions and
>> made some pertinent points.
>>
>> Let me restate:
>>
>> * Today, people who switch between mainline and vendor kernels
>>   experience some pain due to the NIC order changing.
>>
>> * Mainline has had support for Armada 38x for 2 years now, which is
>>   long enough for it to have gained users.  AFAICS, there haven't been
>>   any complaints about the different NIC ordering.  Changing the NIC
>>   ordering is going to cause breakage to these users when they migrate
>>   across the change.
>>
>> By making the change, we're effectively telling these mainline-only
>> users "we don't care about your setups, we're going to break them"
>> because that's exactly what we're going to do.
>>
>> Of course, if no one complains about the change, you've got away
>> with it.
>
> I agree with you that the change isn't perfect, it's really a matter of
> trade-off. The perfect change would be to be able to help the network
> subsystem in its naming of network interfaces, but this has always been
> rejected. It would have indeed been better to add this DT node ordering
> work-around earlier, but we didn't do it, and we're in the present.
>
> So again, yes the proposed change is not "great", but I believe it's
> relatively reasonable. If we indeed get feedback that it's breaking
> things for too many people, I guess we'll just revert. I don't mind if
> things remain as they are today, i.e with a weird ordering of the
> network interfaces. It's just annoying for new people using the
> platform, but it's not horrible either.

I can check during the weekend if the mainlined Linksys boards get broken  
because of this.


Imre

From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 17:52:39 +0200
Subject: [linux-sunxi] Re: [PATCH v3 1/4] dt-bindings: simplefb: Specify
 node location and handoff related properties
In-Reply-To: <5464C444.4050101@redhat.com>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <5464C026.7030300@ti.com> <5464C444.4050101@redhat.com>
Message-ID: <5464D3C7.7060707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 16:46, Hans de Goede wrote:
> Hi,
> 
> On 11/13/2014 03:28 PM, Tomi Valkeinen wrote:
>> On 13/11/14 15:34, Hans de Goede wrote:
>>
>>> +chosen {
>>> +	framebuffer0: framebuffer at 5fc00000 {
>>>  		compatible = "simple-framebuffer";
>>> -		reg = <0x1d385000 (1600 * 1200 * 2)>;
>>> +		reg = <0x5fc00000 (4096 * 1024)>;
>>
>> Was there a reason for this change?
> 
> I changed the node name to match the new bindings text which
> specifies that the node name must be framebuffer@<address>,
> while at it I've taken a real world address range.
> 
> I assume you refer to the bit where the size of the reg property
> is changed ? That indeed is not really necessary.

Yes, I meant the size of the reg prop. As this is an example, I think it
should be as clear as possible.

I guess a valid use case here is to set the size to larger-than-needed,
so that it gets preallocated and you don't need to worry about getting
the memory later when the system has already been running for a longer
time. But if that's the case in this example, I think it would be better
to describe it explicitly.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/b4bb9c35/attachment.sig>

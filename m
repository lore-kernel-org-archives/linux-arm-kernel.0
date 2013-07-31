From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Jul 2013 12:49:20 -0500
Subject: [PATCH 1/7] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAHCPf3svo2q3oCJFzGvU_EKrtvUgAzEgObaXc6aZw7AhuumePg@mail.gmail.com>
References: <20130730094920.GC28716@e106331-lin.cambridge.arm.com>
 <51F7B4C9.2060500@gmail.com>
 <20130730125650.GD28716@e106331-lin.cambridge.arm.com>
 <20130730134427.GE28716@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307301528540.4893@kaball.uk.xensource.com>
 <1375195354.32691.55.camel@kazak.uk.xensource.com>
 <CAHCPf3vUA1bD+1xPch-KZX6fdDzxsWjnVpUD39AKC=ds+EKeHQ@mail.gmail.com>
 <20130731134917.GN29859@e106331-lin.cambridge.arm.com>
 <CAHCPf3svo2q3oCJFzGvU_EKrtvUgAzEgObaXc6aZw7AhuumePg@mail.gmail.com>
Message-ID: <51F94E20.7020904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 12:24 PM, Matt Sealey wrote:
> On Wed, Jul 31, 2013 at 8:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:

[snip]

>>> * An AArch64 guest under an AArch64 hypervisor/sm would use the 64-bit
>>> convention or the 32-bit convention depending on how the sm is
>>> written, but it doesn't matter which is used if both can be
>>> supported.. but you'd only want to use one of them.
>>
>> Not all implementation will implement both, so there needs to be a way
>> to describe that. Which is actually used is up to the OS.
> 
> Okay but putting both ways in a single node, and describing two
> function ids (per property or with two properties) is what I was
> getting at.. for the one case where you can use both at once, the
> device tree description is king here.
> 
> I am a little concerned that the support for this is going down the
> route of telling the OS all possible ways to do the same thing instead
> of trying to get into using a single, preferred way in the common
> cases.
> 
> Putting both call methods in the same node, doubling the function id
> property lengths, or suffixing function id properties to do it seems
> like putting information in the tree purely for the sake of it. In
> what cases would it (uncommon cases only being existing, pre-PCSI
> pre-SMC-conventions potentially for other things). In the case of PSCI
> there's an opportunity to be strict about it.. why would it be sane to
> allow a mixed implementation? Dictate that either support all the
> 64-bit versions or all the 32-bit versions or both? And if both are
> supported, dictate in the device tree which the OS should be using.
> 
> What about having two nodes? There is nothing in device trees that
> says you can't have two psci { compatible="arm,psci-0.2" } nodes, one
> with method=smc and one with method=smc64 or hvc64 or what have you.
> Parsing and setup of the PSCI code can be quit early if it's not the
> "desirable" method for the OS (i.e. 64-bit on a 32-bit kernel). Then
> each node follows the exact same definition, and the differentiator is
> the call method and not the property names or complicating their
> contents.

+1

This would certainly be easier for things like a hypervisor to parse and
update.

Rob

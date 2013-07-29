From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 29 Jul 2013 11:19:10 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <2007664.vYsECFSKrV@flatron> <51F39FD8.6080808@broadcom.com>
 <2460092.aLmjrOVh1g@flatron> <51F3A82E.2000907@broadcom.com>
 <CACxGe6t0C7PTiDDaFkgoMZWUpBVokasxwZpV6HEtf3LaPi4qUw@mail.gmail.com>
 <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
Message-ID: <51F6338E.8020101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2013 10:01 PM, jonsmirl at gmail.com wrote:
> On Sat, Jul 27, 2013 at 3:45 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Sat, Jul 27, 2013 at 4:59 AM, Arend van Spriel <arend@broadcom.com> wrote:
>>> Let's see how many people go and scream if I say this: Too bad .dts files
>>> are not done using XML format as DT bindings could be described using XML
>>> Schema.
>>
>> Draft an example and show us how it would look!  :-)  There is
>> absolutely nothing preventing us from expressing a DT in XML format,
>> or even using XSLT to define DT schema while still using our current
>> .dts syntax. It would be trivial to do lossless translation between
>> .dts syntax and xml.
>>
>> The problem that I have with XML and XSLT is that it is very verbose
>> and not entirely friendly to mere-mortals. However, I'm more than
>> willing to be proved wrong on this point.
>
> I considered this approach a while ago and discarded it. It would work
> but it is just too much of a Frankenstein monster.

Ah, but he is so cute. At least I do not think it is more monstrous as 
the bindings files. I just browsed through a couple of arm binding files 
as I felt challenged to come up with an example. I did not get the 
impression that there is some kind of template in place to get consitent 
bindings descriptions.

> Much cleaner to modify dtc to take a schema as part of the compilation
> process. The schema language itself has no requirement to look like
> DTS syntax. Whoever wrote dtc probably has a favorite language that
> would be good for writing schemas in.

Not sure if I can follow here. I guess you mean the dts compilation, 
right? There are tools freely available to validate XML files against 
XSD specification files. As an example libxml2 has support for it. I 
suspect it is not desired to have a dependency for DTC with an 
out-of-tree library, but it could be incorporated and have DTC spew the 
validation results.

Regards,
Arend

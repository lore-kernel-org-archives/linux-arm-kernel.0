From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jun 2016 13:04:12 +0200
Subject: ARM physical memory map recommendation? (was RE: [RFC] arm64:
 defconfig: enable 48-bit VA by default)
In-Reply-To: <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
References: <HE1PR04MB16416EEC1B49328C2C6F43FB8D500@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <HE1PR04MB1641BF6DC3931FEBEF9716998D530@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <CAKv+Gu-Ra0sAbx1mmuN9o2LZ3Ccs7TsBRm7WyV8SxU6Y3fsEUA@mail.gmail.com>
Message-ID: <7715997.Fa4TyR8lE5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 14, 2016 10:51:57 AM CEST Ard Biesheuvel wrote:
> > I guess how definitive someone might read it is open to interpretation
> > but our hardware guys intepreted it as the "ARM recommendation".
> > There are lot's of "must" statements in there, so its easy for me to
> > see how it can be intepreted to be fairly definitive.  It doesn't
> > say a 64GB DRAM part _could_ be sub-divided like...  It says "For example
> > a 64GB DRAM part _will_ be sub-divided into three regions."
> >
> 
> Whether or not you interpret the tone as normative is only one side of
> it. The reason I quoted the paragraph above is to emphasize that the
> definition of an 'ARM system' is not clear either, i.e., whether it
> means 'any system that implements the ARM architecture' or simply 'a
> system created by ARM Ltd.'. The fact that the paragraph mentions
> software models and FPGA implementations leans to the latter IMO.

Agreed.

> > In any case, we are not going to follow that document as definitive.
> > But, my question is whether there are any updated ARM recommendations?
> 
> That again suggests that the document in question is intended as a
> general recommendation, which I believe may not be the case. So if we
> could get some clarification on that as well from any of the ARM Ltd.
> cc'ees, that would be great.

The other question is to which degree we want to support this in Linux,
e.g. whether it's ok if we only run on systems with such extremely
sparsely populated DRAM areas at the same performance as on the
normal memory maps, or in the default configuration at all.

Do we know of there are any ARM reference systems that even support
more than 32GB of RAM?

	Arnd

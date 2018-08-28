From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 28 Aug 2018 17:29:15 -0500
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
In-Reply-To: <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
 <CADRPPNRvRKEuV=ZzH6yq6_7COvFSWy2ibAKoEt4YrzES2m9x2Q@mail.gmail.com>
 <a8594a1c-0d10-74c6-0e40-15d49ff876a3@linux.vnet.ibm.com>
Message-ID: <CADRPPNSoP5K79wCr5QdJ-OR_W9aZrEkBiPqCXU7EWCfZsvaeuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 5:16 PM Tyrel Datwyler
<tyreld@linux.vnet.ibm.com> wrote:
>
> On 08/28/2018 11:48 AM, Li Yang wrote:
> > On Mon, Aug 27, 2018 at 8:57 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> In preparation to remove the node name pointer from struct device_node,
> >> convert printf users to use the %pOFn format specifier.
> >
> > Please forgive my ignorance, but what is this format specifier do
> > exactly?   I cannot find anything listed in the printf specification
> > matching this.  Is this something newly introduced?
> >
> > Leo
> >
>
> From Documentation/core-api/printk-formats.rst:

I was trying to find it in the standard c format specifier.  :(
Thanks a lot for the pointer.

>
> kobjects
> --------
>
> ::
>
>         %pOF[fnpPcCF]
>
>
> For printing kobject based structs (device nodes). Default behaviour is
> equivalent to %pOFf.
>
>         - f - device node full_name
>         - n - device node name
>         - p - device node phandle
>         - P - device node path spec (name + @unit)
>         - F - device node flags
>         - c - major compatible string
>         - C - full compatible string
>
>
> -Tyrel
>

From: leoli@freescale.com (Li Yang)
Date: Thu, 1 Oct 2015 16:42:05 -0500
Subject: [PATCH v2 07/10] dts/ls2085a: Update DTSI to add support of
 various peripherals
In-Reply-To: <CY1PR0301MB0748A8F37E3FBE1922AF9D3F874C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
 <CAL_Jsq+9izV8vkrF1tK96M-VRGTMJ+GN5o=RsnCBDcnh-at5kA@mail.gmail.com>
 <CALRxmdC9ZzGiw6CVnVTqhH1xvA-P9s8cpYbk8DoVq7CodFS0VA@mail.gmail.com>
 <CY1PR0301MB0748A8F37E3FBE1922AF9D3F874C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <CADRPPNRz-yM_48HvHYv3r31u_b_tHkAjg5H5r+V2mE2=oJTGDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 3:05 PM, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> Hi Rob,
>
> Had a question about your comments on the patch below.
>
> You singled out 3 nodes (gic,uart,clockgen) and said "This should be under a bus node."
>
> What is special about those 3 nodes types?  There are a bunch of other memory
> mapped SoC devices as well in the DTS.
>
> I skimmed the dts files under arch/arm64 and it looks like most have a simple-bus
> SoC node like this where SoC devices are under:
>
>         soc {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 compatible = "simple-bus";
>                 ranges;
>
> Is that what you are looking for-- for all SoC devices?

I think the key is to have the soc node and have all the on-chip
devices defined underneath it.

I read the following from the booting-without-of.txt document:

  f) the /soc<SOCname> node

  This node is used to represent a system-on-a-chip (SoC) and must be
  present if the processor is a SoC. The top-level soc node contains
  information that is global to all devices on the SoC. The node name
  should contain a unit address for the SoC, which is the base address
  of the memory-mapped register set for the SoC. The name of an SoC
  node should start with "soc", and the remainder of the name should
  represent the part number for the soc.  For example, the MPC8540's
  soc node would be called "soc8540".

A lot of device trees didn't follow the soc<SOCname> naming scheme and
just used "soc" as the node name.  I am not sure if we want to enforce
the naming in the future or update the document to make it more relax.

Regards,
Leo

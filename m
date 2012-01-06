From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jan 2012 13:27:51 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
Message-ID: <20120106052748.GA4790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 05:05:46PM -0800, Stephen Warren wrote:
> I'm confused because the node has properties for function name and
> group name which make sense to define the mux setting for that group.
> However, I'm not sure what the grp-pins/num-pins/grp-mux/num-mux
> properties are for; if those properties define the available mux options
> and for the group and set of pins included in the group, I think the node
> is representing too many things in one place. I'd expect to see:
> 
> a) Either data in the pinctrl driver

For imx, I'm against this.

> or separate DT nodes to define each
> available pin group, mux function, etc.; the definition of what the SoC
> itself can do.

This works for me.  But we do not necessarily need to enumerate all
the possible groups from the beginning.  Instead, we can add the groups
incrementally.

Regards,
Shawn

> 
> b) The configuration of each pin group that's used by the particular board.
> All that's relevant here is the mux selection for each pin groups; things
> like which pins are included in each group are defined by the SoC not the
> board and hence wouldn't be included in a per-board node.

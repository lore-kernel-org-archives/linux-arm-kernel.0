From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 19 Oct 2011 08:11:33 -0700
Subject: [RFC] [PATCH] ARM: tegra: emc: device tree bindings
In-Reply-To: <CAOesGMhfAxrG4pMQ86XFzmBnHwBgrD=45eTvmA0-G2gTjaSL6Q@mail.gmail.com>
References: <1318873976-25335-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CBFB@HQMAIL01.nvidia.com>
	<CAOesGMh387Oghyd_TobnTOja6tU2uU5kt-86_HwQe7nFiL+svw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CC18@HQMAIL01.nvidia.com>
	<CAOesGMghu6Bn3RrFKEUBKkUNS_K8Y0ho3Y2uFZh_LXbfT80hFw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CCA9@HQMAIL01.nvidia.com>
	<4E9E3801.6080707@gmail.com>
	<CAOesGMj8TREZ94RFhE3Qy=eaytOuB0YKBWw6--HAERoMB9m7Qg@mail.gmail.com>
	<4E9EE07A.20301@gmail.com>
	<CAOesGMhfAxrG4pMQ86XFzmBnHwBgrD=45eTvmA0-G2gTjaSL6Q@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173D51BDEB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, October 19, 2011 9:07 AM:
> On Wed, Oct 19, 2011 at 7:36 AM, Rob Herring <robherring2@gmail.com> wrote:
...
> > Using the frequency as was previously proposed would work assuming that
> > is unique.
> 
> Someone suggested (off-list) to just use dummy addressing like cpu
> nodes do. Sounds reasonable to me.
> 
> So:
> 
> emc {
>   compatible = "tegra20-emc";
>   nvidia,use-ram-code;
>   emc-tables@<ram-code> {
>      nvidia,ram-code = < <ram-code> >;
>      emc-table@<dummy enumerator> {
>         compatible = "tegra20-emc-table";
>         clock-frequency = < >;
>         nvidia,emc-regs = < >;
>      }
>   }
> 
> This also avoids having to handle 2-dimensional dummy numbering (i.e.
> <ramcode,table-number>) by breaking it in two levels:
> 
> Where nvidia,use-ram-code is missing in the emc node, the immediate
> child nodes will be scanned for the compatible nodes
> Where nvidia,use-ram-code is present, first scan will be of all child
> nodes containing an nvidia,ram-code property, then from there treat it
> the same as the first case.
> 
> In the above, none of the names have meaning, so they can be changed
> as needed (but these seem like a reasonably generic and descriptive
> name to me).

OK, I'm good with that general structure.

But, as Rob suggests, you may as well use the frequency instead of the
<dummy enumerator> for the unit address of the final tables, right?
The search algorithm might not care, but it'll be easier for humans
to read the resulting dts file.

-- 
nvpublic

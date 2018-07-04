From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 4 Jul 2018 01:42:54 +0000
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
References: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
 <AM3PR04MB131507901BFEE1A5E426EECBF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8tjnjbwMdLGd7KF7_4PwqRWX8XH8kdcF3-5e-r2YQEA@mail.gmail.com>
 <AM3PR04MB1315E7AED2BCE2265E6C443DF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5D8v4KM9S4ooHTDbA+vc8BZN_eO_wDuOPA+8Hcq-SmLDw@mail.gmail.com>
 <AM3PR04MB1315C7C7CFF990615732FFBCF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AM5VRS7UiWuvAQ8vvTB8OM+iwofuYrbsL_yB9e0Z9Kyg@mail.gmail.com>
 <AM3PR04MB13155B8D567ABEF7EF03249AF5430@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BdtxKjQge5ONpnjr1yNVeTJf4u8Gh-fPqpHz7G9ipOTg@mail.gmail.com>
 <1530526335.15665.13.camel@nxp.com> <20180703053843.GC4348@dragon>
 <AM3PR04MB131542D42FCD798FDBBA54BFF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BY99f5jjU+73=8WjqwBKr_q2S1mvx90URZUBkgOVn9YA@mail.gmail.com>
Message-ID: <1530697336.15665.43.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2018-07-03 at 08:10 -0300, Fabio Estevam wrote:
> Hi Anson,
> 
> On Tue, Jul 3, 2018 at 4:44 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > 
> > It is NOT easy to identify which switch is critical or NOT, and
> > different platforms
> > have different board design, it will introduce many platform
> > specified code, so I think
> > just revert the pfuze100 switch enable/disable patch should be OK
> > for now.
> I have sent the pfuze100 regulator patch revert and it is linux-next
> now. Should probably reach 4.18-rc4.
> 
> > 
> > After a couple of release cycles, add the pfuze100 switch
> > enable/disable patch
> > back to support this feature, I believe users should switch to new
> > dtb with "regulator-always-on"
> > existing already.
> That will still break old dtb compatibility.
> 
> You cannot force users to use "regulator-always-on" and the old dtbs
> need to always work.
> 
> So whatever new feature you need to introduce it needs to be done in
> such a way that the existing dtb's will continue working.
But actually existing dtb is not right since the critical power rail
missing 'regulator-always-on'. It's a fix patch for dts, not related
with following dtb/kernel break rules, just a simple dts patch. Why
should we make promise for the wrong dtbs?
